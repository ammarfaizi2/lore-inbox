Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286976AbRL1Smg>; Fri, 28 Dec 2001 13:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286983AbRL1Sm1>; Fri, 28 Dec 2001 13:42:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38919 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286976AbRL1SmX>; Fri, 28 Dec 2001 13:42:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: zImage not supported for 2.2.20?
Date: 28 Dec 2001 10:42:17 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a0iee9$s90$1@cesium.transmeta.com>
In-Reply-To: <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <20011228121228.GA9920@emma1.emma.line.org> <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1>
By author:    Roy Hills <linux-kernel-l@nta-monitor.com>
In newsgroup: linux.dev.kernel
> 
> Unfortunately, I need to use zImage on my Tecra.  I know that zImage is
> old, and I've heard that support for it will eventually be withdrawn, but I
> don't really have much alternative right now unless there is a patch which
> works around the Tecra's buggy A20 handling.
> 

Oh, by the way, the "I need to use zImage on my Tecra" thing is making
it work by the use of voodoo.  It's rather unfortunate it worked on
some systems -- it's going to fail randomly on you anyway; it's just a
matter of which way the timings and cache items get jerked around.

I have asked Alan for more details on the workaround, but perhaps the
thing to do is to backport the latest 2.4 A20 code back to 2.2 and see
if that solves the *real* problem, so bzImage works.

I don't think there is any reason to believe zImage doesn't work
unless bzImage works on your system.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
