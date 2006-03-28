Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWC1BRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWC1BRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 20:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWC1BRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 20:17:38 -0500
Received: from ns.mimer.no ([213.184.200.1]:60128 "EHLO odin.mimer.no")
	by vger.kernel.org with ESMTP id S1751037AbWC1BRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 20:17:37 -0500
From: Harald Arnesen <harald@skogtun.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Mark Lord <lkml@rtr.ca>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: regular swsusp flamewar
References: <200603231702.k2NH2OSC006774@hera.kernel.org>
	<442325DA.80300@rtr.ca> <20060327102636.GH14344@elf.ucw.cz>
	<200603272044.05431.ncunningham@cyclades.com>
	<20060327231557.GB2439@elf.ucw.cz>
Date: Tue, 28 Mar 2006 03:16:22 +0200
In-Reply-To: <20060327231557.GB2439@elf.ucw.cz> (Pavel Machek's message of
	"Tue, 28 Mar 2006 01:15:57 +0200")
Message-ID: <87mzfb9xnd.fsf@basilikum.skogtun.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

>> You know that I disagree that doing suspend in userspace is the
>> right 
>
> You know "disagreeing" with subsystem maintainer (and everyone else
> for that matter) is not exactly helpful in getting patches merged. You
> are free to believe whatever you want, but if you disagree on
> something as fundamental as "do not put unneccessary code to kernel"
> with me, it should be no surprise that I "disagree" with your patches
> (*).
>
>> approach, and you know that current uswsusp can't do everything Suspend2 does 
>> without further substantial modification. Please stop painting me as the bad 
>> guy because I won't roll over and play dead for you. Please also
>> stop 
>
> I'm not trying to paint you as a bad guy. But Mark said you are trying
> to help, and in that context I'd read it as "trying to help mainline
> development". And you are not doing that, you are developing your own
> suspend2 branch, that has nothing to do with mainline. I think we can
> agree on that one...

The main point for me is that suspend2 works, while mainline supspend
does not ("works": it takes less time to suspend/resume than to
shutdown/reboot).

I haven't tried uswsusp yet. Why try another out-of-kernel suspend when
suspend2 works perfectly?
-- 
Hilsen Harald.

