Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWC1KSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWC1KSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 05:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWC1KSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 05:18:02 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53642 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751296AbWC1KR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 05:17:59 -0500
Date: Tue, 28 Mar 2006 11:13:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Harald Arnesen <harald@skogtun.org>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Mark Lord <lkml@rtr.ca>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: regular swsusp flamewar
Message-ID: <20060328091344.GC2874@elf.ucw.cz>
References: <200603231702.k2NH2OSC006774@hera.kernel.org> <442325DA.80300@rtr.ca> <20060327102636.GH14344@elf.ucw.cz> <200603272044.05431.ncunningham@cyclades.com> <20060327231557.GB2439@elf.ucw.cz> <87mzfb9xnd.fsf@basilikum.skogtun.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mzfb9xnd.fsf@basilikum.skogtun.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 28-03-06 03:16:22, Harald Arnesen wrote:

> The main point for me is that suspend2 works, while mainline supspend
> does not ("works": it takes less time to suspend/resume than to
> shutdown/reboot).
> 
> I haven't tried uswsusp yet. Why try another out-of-kernel suspend when
> suspend2 works perfectly?

uswsusp is not out-of-tree any more (but you'll need recent tree from
git). You should try in-kernel options before patching your kernel,
I'd say. Userland tools are at suspend.sf.net.

								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
