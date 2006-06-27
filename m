Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWF0Naz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWF0Naz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWF0Naz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:30:55 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:27103 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932277AbWF0Nay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:30:54 -0400
Date: Tue, 27 Jun 2006 15:30:43 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.17-ck1: fcache problem...
Message-ID: <20060627153043.60582710@localhost>
In-Reply-To: <20060627131033.GU22071@suse.de>
References: <20060625093534.1700e8b6@localhost>
	<20060625102837.GC20702@suse.de>
	<20060625152325.605faf1f@localhost>
	<20060625174358.GA21513@suse.de>
	<20060627112105.0b15bfa1@localhost>
	<20060627095443.GQ22071@suse.de>
	<20060627122457.2cabc4d7@localhost>
	<20060627150440.0aaf07e1@localhost>
	<20060627131033.GU22071@suse.de>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 15:10:33 +0200
Jens Axboe <axboe@suse.de> wrote:

> > Cannot the code figure out this himself al let "mount -o remount,ro"
> > work?
> 
> It could be fixed up, yes, but for now you have to always pass the fdev
> option for it to work. Sorry, I thought you knew that, I think I wrote
> that in the original mail as well.

No ;)

http://lkml.org/lkml/2006/5/15/46

you talked about remounting rw at boot (modifing distro script) and
remounting for stopping priming.

> 
> But it needs to be fixed of course, also so you don't have to do it for
> 'rw' remounts (which I sometimes do just to check stats).

I agree :)

-- 
	Paolo Ornati
	Linux 2.6.17-gd2581eb4 on x86_64
