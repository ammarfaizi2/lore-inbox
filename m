Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWE3TZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWE3TZS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWE3TZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:25:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41315 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932428AbWE3TZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:25:16 -0400
Date: Tue, 30 May 2006 21:27:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
Message-ID: <20060530192708.GK4199@suse.de>
References: <20060527133122.GB3086@redhat.com> <20060530131728.GX4199@suse.de> <20060530161232.GA17218@redhat.com> <20060530164917.GB4199@suse.de> <20060530165649.GB17218@redhat.com> <20060530170435.GC4199@suse.de> <20060530184911.GD4199@suse.de> <20060530185158.GG4199@suse.de> <20060530191126.GJ4199@suse.de> <20060530192355.GE17218@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530192355.GE17218@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2006, Dave Jones wrote:
> On Tue, May 30, 2006 at 09:11:28PM +0200, Jens Axboe wrote:
> 
>  > > > > Just do a l *cfq_set_request+0x202 from gdb if you have
>  > > > > CONFIG_DEBUG_INFO enabled in your vmlinux.
>  > > > 
>  > > > Doh, found it. Dave, please try and reproduce with this applied:
>  > > 
>  > > Nevermind, that's not it either. Damn. Stay tuned.
>  > 
>  > Try this instead, please.
> 
> Heh, I was waiting forever to get that debuginfo package downloaded & unpacked.
> I'll throw this into my next build, and see what happens.
> Is this likely to fix the slab corruption bug I first reported,
> or the list corruption as seen in the bugzilla, or (optimistically) both ?

Both, it's the same bug.

-- 
Jens Axboe

