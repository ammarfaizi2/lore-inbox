Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268838AbRG0MsG>; Fri, 27 Jul 2001 08:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267980AbRG0Mrz>; Fri, 27 Jul 2001 08:47:55 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:42763 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266578AbRG0Mrm>; Fri, 27 Jul 2001 08:47:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Paul G. Allen" <pgallen@randomlogic.com>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>,
        "kplug-lpsg@kernel-panic.org" <kplug-lpsg@kernel-panic.org>
Subject: Re: Linx Kernel Source tree and metrics
Date: Fri, 27 Jul 2001 14:52:30 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B612D26.BA131CEC@randomlogic.com>
In-Reply-To: <3B612D26.BA131CEC@randomlogic.com>
MIME-Version: 1.0
Message-Id: <01072714523106.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 10:58, Paul G. Allen wrote:
> For those interested, I have run the kernel (2.4.2-2) through a
> program and generated extensive HTML reports including call trees,
> function and data declarations, source code, and metrics. I plan to
> upgrade this to the latest kernel and keep it up to date (as much as
> possible :), but I am a) working with a kernel that I know currently
> runs on my dual Athlon, and b) wanted to test this out and run it by
> the two lists first.
>
> My bandwisth is currently limited (cable modem), but if it's decided
> that I'll keep this available, I will upload it to a web server with
> a couple T1's avalable (or maybe I will use one of our companies
> servers on a DS3 or greater).
>
> The URL is:
>
> http://24.5.14.144:3000/linux-kernel
>
> If you have any connection problems (and there may be, since it's
> currently running on the same machine I'm using to develop with - the
> dual Athlon), suggestions (even if it's "hey, dork, it's already
> available at http://xxx.yyy"), or whatever, please let me know.

Nit 1: I'd prefer the following format for the data dictionary:

-m   (Local Object)[xref]
-   [wavelan_cs.c, 564]
-
+m  [xref] [wavelan_cs.c, 564] (Local Object)

I.e., three times as many entries on the screen and with the
constant-width part aligned.

Nit 2: You can drop the "Report" from the name of every section, we
know it's a report.

I'm continuing to explore this wonderful resource.  Do you intend to
GPL the source?

--
Daniel
