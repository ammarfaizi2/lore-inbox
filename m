Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270319AbRHSPBx>; Sun, 19 Aug 2001 11:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270519AbRHSPBd>; Sun, 19 Aug 2001 11:01:33 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:11199
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S270319AbRHSPB0>; Sun, 19 Aug 2001 11:01:26 -0400
Date: Sun, 19 Aug 2001 08:01:41 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: <lk@Aniela.EU.ORG>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs question
In-Reply-To: <Pine.LNX.4.33.0108191745310.365-100000@ns1.Aniela.EU.ORG>
Message-ID: <Pine.LNX.4.33.0108190757260.27721-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001 lk@Aniela.EU.ORG wrote:

> I run slackware-linux 8.0 and when I restart my box without issuing the
> halt command, I see the following message when the kernel boots:
>
> reiserfs: checking transaction log (device 03:01) ...
> Warning, log replay starting on readonly filesystem

Perhaps you have a "read-only" line in the lilo.conf section for whatever
kernel you're booting.  It's possible that initscripts are remounting the
partition read-only, but not likely, and if you're using journalling, it's
best to check your initscripts and get rid of all the junk that runs
e2fsck and then remounts read-write.


justin

