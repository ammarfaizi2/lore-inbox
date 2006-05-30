Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWE3TYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWE3TYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWE3TYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:24:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5090 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932422AbWE3TYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:24:13 -0400
Date: Tue, 30 May 2006 15:23:55 -0400
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
Message-ID: <20060530192355.GE17218@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060527070724.GB24988@suse.de> <20060527133122.GB3086@redhat.com> <20060530131728.GX4199@suse.de> <20060530161232.GA17218@redhat.com> <20060530164917.GB4199@suse.de> <20060530165649.GB17218@redhat.com> <20060530170435.GC4199@suse.de> <20060530184911.GD4199@suse.de> <20060530185158.GG4199@suse.de> <20060530191126.GJ4199@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530191126.GJ4199@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 09:11:28PM +0200, Jens Axboe wrote:

 > > > > Just do a l *cfq_set_request+0x202 from gdb if you have
 > > > > CONFIG_DEBUG_INFO enabled in your vmlinux.
 > > > 
 > > > Doh, found it. Dave, please try and reproduce with this applied:
 > > 
 > > Nevermind, that's not it either. Damn. Stay tuned.
 > 
 > Try this instead, please.

Heh, I was waiting forever to get that debuginfo package downloaded & unpacked.
I'll throw this into my next build, and see what happens.
Is this likely to fix the slab corruption bug I first reported,
or the list corruption as seen in the bugzilla, or (optimistically) both ?

Thanks,

		Dave

-- 
http://www.codemonkey.org.uk
