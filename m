Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288090AbSANIFF>; Mon, 14 Jan 2002 03:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288102AbSANIEz>; Mon, 14 Jan 2002 03:04:55 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:61071 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S288090AbSANIEu>; Mon, 14 Jan 2002 03:04:50 -0500
Date: Mon, 14 Jan 2002 10:03:34 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
Message-ID: <Pine.LNX.4.33.0201141003190.28735-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You haven't taken into consideration that not many distributions have
drivers in kernel, and in particular ISA device drivers. Namely because
ISA probes are ugly and require frobbing of memory in the vague hopes of
finding said device there. These probes may put ye old ISA device in a bad
state sometimes even hard locking your box, so chances are if the ISA
probe is in dmesg, the user explicitely decided to load the device. In
which case they already know what they have...

As an aside, i try not to use ISA and elegant in the same sentence ;)

Regards,
	Zwane Mwaikambo



