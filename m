Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132524AbRC1Uwe>; Wed, 28 Mar 2001 15:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132522AbRC1UwY>; Wed, 28 Mar 2001 15:52:24 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1284 "EHLO bug.ucw.cz") by vger.kernel.org with ESMTP id <S132515AbRC1UwH>; Wed, 28 Mar 2001 15:52:07 -0500
Date: Mon, 26 Mar 2001 01:15:36 +0000
From: Pavel Machek <pavel@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NTP on 2.4.2?
Message-ID: <20010326011535.C50@(none)>
References: <20010323162345.A24604@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010323162345.A24604@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Mar 23, 2001 at 04:23:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm having problems getting my 2.4.2 kernel to synchronise properly.  For
> some reason, NTP is insisting on making time offset adjustments.

Are you using fbcon? If so, and if it goes away after starting X, then it is
the "fbcon kills interrupt latency" problem.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

