Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312279AbSDKQxE>; Thu, 11 Apr 2002 12:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312376AbSDKQxD>; Thu, 11 Apr 2002 12:53:03 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:26866 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S312279AbSDKQxC>; Thu, 11 Apr 2002 12:53:02 -0400
Date: Thu, 11 Apr 2002 12:51:29 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Pierre Ficheux <pierre.ficheux@openwide.fr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 AND Geode GX1/200Mhz problem
In-Reply-To: <Pine.LNX.4.44.0204081311370.25445-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.GSO.4.33.0204111246400.29312-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Zwane Mwaikambo wrote:
>Or you can boot with kernel parameter notsc which should have the effect.

One might think that, but it isn't true.  That'll just stop the kernel from
halting immediately when it doesn't find any tsc capability.  The system
still locks up -- maybe some other parts of the kernel tries to use tsc?
I never looked into it as compiling the kernel correctly (sans tsc) works
just fine.

On a side note, has anyone seen dd scrolling behavior with video chipse
using shared memory?  On the geode board I'm playing with, the screen
never scrolls correctly.  It's probablly something stupid in the 5530's
setup that's at fault. (I have ever intention of turning the VGA port
off entirely.)

--Ricky


