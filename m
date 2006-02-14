Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWBNAal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWBNAal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWBNAal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:30:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63206 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030303AbWBNAak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:30:40 -0500
Date: Mon, 13 Feb 2006 19:29:14 -0500
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
Subject: Re: 2.6.16-rc3: more regressions
Message-ID: <20060214002914.GB15878@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org> <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org> <21d7e9970602131608y77c35b4fn63b8eeb4101a44d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970602131608y77c35b4fn63b8eeb4101a44d1@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 11:08:16AM +1100, Dave Airlie wrote:
 > >
 > > DaveA, I'll apply this for now. Comments?
 > >
 > 
 > (sorry - I've been finding my way back home from Xdevconf, just landed)...
 > 
 > I asked DaveJ I believe in one thread to disable Load "dri" in his
 > xorg.conf and report back,

Ah sorry about that.  You were just about to go to LCA when that came
up, so I figured I'd wait until you had time to look at it again :)

There's a log at http://people.redhat.com/davej/Xorg.0.log
That doesn't have drm disabled, but it is being run on a kernel
with the pci id commented out.  I'm a bit reluctant to reboot
the workstation to try a non-drm enabled X at the moment, until
some stuff finishes.  Let me know if that log is insufficient or not.

		Dave
