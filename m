Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268439AbUHXWC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268439AbUHXWC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268388AbUHXWC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:02:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:680 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268421AbUHXWA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:00:56 -0400
Date: Tue, 24 Aug 2004 14:58:50 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
Message-Id: <20040824145850.243b6d94.rddunlap@osdl.org>
In-Reply-To: <412BB7AE.7050804@zytor.com>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
	<412BB7AE.7050804@zytor.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 14:48:30 -0700 H. Peter Anvin wrote:

| Linus Torvalds wrote:
| > Ok,
| >  tons of patches merged, with me being away for a week, and also the
| > normal pent-up patch demand after any stable kernel. Special thanks as
| > always to Andrew, who synced up 200+ patches (he's attributed in the
| > sign-off lines, but not in the appended shortlog, so I just wanted to
| > point that out).
| > 
| > Changes all over: arm, ppc, sparc, acpi, i2c, usb, fbcon, ntfs, xfs, nfs,
| > cpufreq, agp, sata, network drivers - you name it. Most of the changes are
| > fairly small, but there's a lot of them.
| > 
| > Administrative trivia, and one thing I agonized over: should I make the
| > patches relative to 2.6.8 or 2.6.8.1? I decided that since there is
| > nothing that says that a "basic bug-fix" releases for a previous release
| > might not happen _after_ we've done a -rc release for the next version, I
| > can't sanely do patches against a bugfix release.
| > 
| > Thus the 2.6.9-rc1 patch is against plain 2.6.8. If you have 2.6.8.1, you
| > need to undo the .1 patch, and apply the big one. BK users and tar-balls 
| > don't see that particular confusion, of course ;)
| > 
| 
| The kernel.org scripts I am pretty sure will assume 2.6.9-rc1 are against 
| 2.6.8, not 2.6.8.1.

Hey, I'll chime in and make it unanimous.  Maybe easier scripting like
Matt said, but definitely makes more sense (less surprise) for users
IMO.

--
~Randy
