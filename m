Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVDTJGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVDTJGB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 05:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVDTJGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 05:06:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14481 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261451AbVDTJFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 05:05:47 -0400
Subject: Re: Module that loads new Interrupt Descriptor Table
From: Arjan van de Ven <arjan@infradead.org>
To: Zvi Rackover <zvirack@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <28183df5050420015828ace752@mail.gmail.com>
References: <28183df5050420015828ace752@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 11:05:40 +0200
Message-Id: <1113987941.6238.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-20 at 11:58 +0300, Zvi Rackover wrote:
> Hello all,
>  
>   I would like to write a program that monitors various system
> parameters in real time. One of these is counting the number of
> interrupts. I would like to implement my own interrupt handler so that
> each handler counts the number of interrupt of its respective type.

ehm
the kernel already keeps this kind of data, see /proc/interrupts

why would you want to collect it *again* ?
(or do you want to generally hook interrupts like some other people want
to hook syscalls?)


