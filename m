Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVHGJdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVHGJdk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 05:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVHGJdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 05:33:40 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:13465 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751350AbVHGJdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 05:33:39 -0400
Date: Sun, 7 Aug 2005 11:41:29 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes.  Also some X trouble.
Message-ID: <20050807094129.GA10857@aitel.hist.no>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <20050805104025.GA14688@aitel.hist.no> <20050805150506.703e804f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805150506.703e804f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 03:05:06PM -0700, Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
[...]
> > The two kernels have some config differences.  The 2.6.13-rc5 kernel
> > has ACPI+CPUFREQ configured, that the 2.6.13-rc4-mm1 doesn't have.
> 
> That's a pretty big difference ;)
> 
Sure.
> > ...
> > I can run more tests, but don't know what would be the most interesting.
> > rc5 without powermanagement?  rc4-mm1 with it? Or the newest git kernel?
> > Or is this the effect of some known problem?
> 
> The latest -git kernel (or 2.6.13-rc6 if it's there) with APCI enabled is
> the one to test, please.
> 
I tried 2.6.13-rc5-git4, with and without ACPI. They seem to behave
identical:

I haven't seen any more disk trouble, but one of my X displays go black
now and then, forcing me to do a display resize to get it back.  This
does not happen at all with 2.6.13-rc4-mm1.

The display that goes black uses the evdev protocol to read the
second keyboard which is not connected to any tty.  That is a very
new option which could have its own issues, but there where no problems 
in rc4-mm1. It is annoying enough that I don't want to run rc5 for
anything but tests.

Helge Hafting
