Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268744AbRG0AYZ>; Thu, 26 Jul 2001 20:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268746AbRG0AYP>; Thu, 26 Jul 2001 20:24:15 -0400
Received: from [209.250.53.142] ([209.250.53.142]:7942 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S268744AbRG0AYJ>; Thu, 26 Jul 2001 20:24:09 -0400
Date: Thu, 26 Jul 2001 19:23:15 -0500
From: Steven Walter <srwalter@yahoo.com>
To: "Manuel A. McLure" <mmt@unify.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] Error compiling glide3 cvs tree from 26 Juli
Message-ID: <20010726192315.B25074@hapablap.dyn.dhs.org>
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C3D1@pcmailsrv1.sac.unify.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C3D1@pcmailsrv1.sac.unify.com>; from mmt@unify.com on Thu, Jul 26, 2001 at 03:49:25PM -0700
X-Uptime: 5:41pm  up 10:05,  0 users,  load average: 1.14, 1.12, 1.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 03:49:25PM -0700, Manuel A. McLure wrote:
> Actually, I believe the 3DNow stuff is turned off by default - at least
> configure.in says so. When (a long time ago) I tried to build a
> 3DNow-enabled Glide, I found that I had to modify Makefile.autoconf.am in
> h5/glide3/src to get it to compile. The resulting Glide library would work
> for simple things (like gears), but would hang if I tried something more
> complicated like q3demo (in fact it would hand on the splash screen). As a
> result I am back to non-3DNow Glide. I'd like to see a 3DNow-enabled Glide,
> but I definitely don't have the skills to figure it out myself...
> 
> --
> Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
> Zathras is used to being beast of burden to other peoples needs. Very sad
> life. Probably have very sad death, but at least there is symmetry.

You're right.  I've examined it some more, and it turns out I'm wrong.
The 3DNow! routines aren't actually used by default.

Just out of curiousity, how much of a speed improvement could one expect
with 3DNow! versus the code used currently?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
