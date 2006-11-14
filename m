Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966251AbWKNSRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966251AbWKNSRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966252AbWKNSRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:17:43 -0500
Received: from mail.ggsys.net ([69.26.161.131]:20379 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S966251AbWKNSRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:17:42 -0500
Subject: Re: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4559F2EE.7080309@rtr.ca>
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>
	 <1163180185.28843.13.camel@w100>  <4556AC74.3010000@rtr.ca>
	 <1163363479.3423.8.camel@w100>  <45588132.9090200@rtr.ca>
	 <1163479852.3340.9.camel@w100>  <4559F2EE.7080309@rtr.ca>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Tue, 14 Nov 2006 12:17:38 -0600
Message-Id: <1163528258.3340.23.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds good, let me know if you need me to do any
testing or help on the programming. I've been wanting
to get into kernel drivers, but never did find the
right time/place to do it.

Thanks,

Alberto

On Tue, 2006-11-14 at 11:46 -0500, Mark Lord wrote:
> Alberto Alonso wrote:
> > Things are improving, after the latest patch I can still
> > see spurious messages, but the count stays at 0.
> 
> Mmm.. Okay, so we have a kludge fix (just get rid of the printk's we added).
> 
> But I would like to find out more about what is going on.
> We seem to be getting lots of "leftover interrupts".
> I'll look through my full qstor block driver (the high-performance
> queuing driver, out-of-tree), and see if we missed an IRQ-mask bit
> someplace in the simple sata_qstor.c re-implementation.
> 
> Cheers
-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

