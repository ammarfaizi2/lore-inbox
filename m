Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132191AbRCVVJt>; Thu, 22 Mar 2001 16:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132193AbRCVVJj>; Thu, 22 Mar 2001 16:09:39 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:25092 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S132183AbRCVVJT>;
	Thu, 22 Mar 2001 16:09:19 -0500
Date: Thu, 22 Mar 2001 13:20:40 +0000
From: Pavel Machek <pavel@suse.cz>
To: garlof@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP on assym. x86
Message-ID: <20010322132040.A31@(none)>
In-Reply-To: <20010321165541.H3514@garloff.casa-etp.nl> <99anl4oi@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <99anl4oi@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Mar 21, 2001 at 09:16:20AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Kurt Garloff  <garloff@suse.de> wrote:
> >
> >recently upgrading one of my two CPUs, I found kernel-2.4.2 to be unable to
> >handle the situation with 2 different CPUs (AMP =3D Assymmetric
> >multiprocessing ;-) correctly.
> 
> This is not really a configuration Linux supports. You can hack it to
> work in many cases, but I'm generally not inclined to make this a an
> issue for me because:

Notice, that one of your CPUs is twice as fast as second one. You'll
need some heavy updates in scheduler.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

