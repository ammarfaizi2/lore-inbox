Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbSLLXKB>; Thu, 12 Dec 2002 18:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbSLLXKB>; Thu, 12 Dec 2002 18:10:01 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31889 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267532AbSLLXKA>; Thu, 12 Dec 2002 18:10:00 -0500
Date: Thu, 12 Dec 2002 18:17:47 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (8/8): export sys_wait4.
Message-ID: <20021212181747.B28477@devserv.devel.redhat.com>
References: <20021212142645.A2998@devserv.devel.redhat.com> <3DF8FD59.9030100@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DF8FD59.9030100@drugphish.ch>; from ratz@drugphish.ch on Thu, Dec 12, 2002 at 10:19:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 12 Dec 2002 22:19:21 +0100
> From: Roberto Nibali <ratz@drugphish.ch>

> >>+EXPORT_SYMBOL(sys_wait4);
> > 
> > Martin, hold on just a second. Last I checked, sys_wait4 was
> > used ONLY by a moronic code in ipvs, _and_ there was a comment
> > by the author above it "we are too lazy to do it properly".
> > Do you have a better reason to export it?
> 
> Guess I'm the malefactor this time since I've sent this patch to Martin 
> after some email exchanges with a guy that wanted LVS to work on a s390. 
> I reckon I will fix the said moronic code to use a syscall wrapper for 
> sys_wait4() so we don't step on anyone's toes.

I should not have called it moronic. Everyone has schedule
constraints. I am wondering though, if the LVS and ipvs
module are maintained actively. Perhaps I owe them a patch.

-- Pete
