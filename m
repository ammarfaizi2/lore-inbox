Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbVJETk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVJETk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVJETk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:40:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4818 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030341AbVJETk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:40:56 -0400
Subject: Re: Waring in kernel 2.6.10
From: Arjan van de Ven <arjan@infradead.org>
To: umesh chandak <chandak_pict@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051005192754.11115.qmail@web35905.mail.mud.yahoo.com>
References: <20051005192754.11115.qmail@web35905.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 21:40:49 +0200
Message-Id: <1128541252.2920.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 12:27 -0700, umesh chandak wrote:
> hi,
>            I have compiled a kernel 2.6.10 on FC3 it
> gives me the warning like this 
> 
> 

you forgot to make an initrd.

you're best of using "make install" as last step in your kernel build
process, that does the initrd automatic and as a bonus also adds your
kernel to the grub bootloader automatically


