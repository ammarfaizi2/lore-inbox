Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292323AbSBPDN0>; Fri, 15 Feb 2002 22:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292343AbSBPDNR>; Fri, 15 Feb 2002 22:13:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:45247 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292319AbSBPDND>;
	Fri, 15 Feb 2002 22:13:03 -0500
Date: Sat, 16 Feb 2002 03:11:12 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216021112.GA23230@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com> <200202152209.g1FM9PZ00855@vindaloo.ras.ucalgary.ca> <20020215165029.C14418@thyrsus.com> <20020215143807.L28735@work.bitmover.com> <20020215232312.GB12204@merlin.emma.line.org> <20020216002959.P27880@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020216002959.P27880@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2002, Dave Jones wrote:

> On Sat, Feb 16, 2002 at 12:23:12AM +0100, Matthias Andree wrote:
>  > Are you telling that kernel programmers don't rewrite code from scratch?
>  > Is that a correct interpretation of "improve the existing system"? Note
>  > that "it can't be done" can also imply "cannot reasonable be done".
>  > Eric has done it, without being of kernel hacker temple's fame.
> 
>  The kernel hacker approach: Gradual change toward a predefined goal.
>  The Eric approach: Rip out existing, replace with new.
> 
>  If Al Viro can rewrite the guts of the VFS without hardly anyone
>  noticing any disturbance, and the configuration system can't be
>  done this way, something is amiss.

Not necessarily. If the gradual change infers intermediate functions
that are not needed for a hard cut-over, it's no good to do all the
extra work if the already-existing result is known to work. I'd
certainly not drop CML1 from 2.4, but 2.5 is the time for changes.

You don't take an airplane to drive alongs autobahns for a gradual
change either.

It seems to me as though the "rip out existing" issue was rather a
"don't let us maintain two parts of the same type at the same time"
convenience feature than a trait of CML2, and if so, keep both for some
releases and drop CML1 in, say, 2.5.8.
