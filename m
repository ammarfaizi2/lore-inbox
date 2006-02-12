Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWBLNRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWBLNRm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 08:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWBLNRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 08:17:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45495 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750717AbWBLNRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 08:17:41 -0500
Subject: Re: Badness in sleep_on_timeout on kernel 2.6.9-1.667 ( fedora
	core 3)
From: Arjan van de Ven <arjan@infradead.org>
To: anil dahiya <ak_ait@yahoo.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <20060207200013.30703.qmail@web60221.mail.yahoo.com>
References: <20060207200013.30703.qmail@web60221.mail.yahoo.com>
Content-Type: text/plain
Date: Sun, 12 Feb 2006 14:17:34 +0100
Message-Id: <1139750255.20703.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 12:00 -0800, anil dahiya wrote:
> Hello 
> I am creating kernel thread on fedora core 4
> (2.6.9-1.667)and my getting oops something like
> 
>  Badness in sleep_on_timeout at kernel/sched.c:3022
>  [<02302bc3>] sleep_on_timeout+0x5d/0x23a
>  [<0211b919>] default_wake_function+0x0/0xc


you forgot to post a URL to your code
(and you use sleep_on_* family of APIs which is a bug in itself)

