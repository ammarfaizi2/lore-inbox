Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbUCCKFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbUCCKFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:05:45 -0500
Received: from ns.suse.de ([195.135.220.2]:58252 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262399AbUCCKFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:05:37 -0500
Date: Wed, 3 Mar 2004 11:05:15 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: George Anzinger <george@mvista.com>, amitkale@emsyssoft.com, ak@suse.de,
       pavel@ucw.cz, linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040303100515.GB8008@wotan.suse.de>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <200402061914.38826.amitkale@emsyssoft.com> <403FDB37.2020704@mvista.com> <200403011508.23626.amitkale@emsyssoft.com> <4044F84D.4030003@mvista.com> <20040302132751.255b9807.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302132751.255b9807.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 01:27:51PM -0800, Andrew Morton wrote:
> George Anzinger <george@mvista.com> wrote:
> >
> >  Often it is not clear just why we are in the stub, given that 
> > we trap such things as kernel page faults, NMI watchdog, BUG macros and such.
> 
> Yes, that can be confusing.  A little printk on the console prior to
> entering the debugger would be nice.

What I did for kdb and panic some time ago was to flash the keyboard
lights. If you use a unique frequency (different from kdb 
and from panic) it works quite nicely.

-Andi
