Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313472AbSDYVIZ>; Thu, 25 Apr 2002 17:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSDYVIY>; Thu, 25 Apr 2002 17:08:24 -0400
Received: from air-2.osdl.org ([65.201.151.6]:57867 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313472AbSDYVIY>;
	Thu, 25 Apr 2002 17:08:24 -0400
Date: Thu, 25 Apr 2002 14:02:26 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <gjwucherpfennig@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic while booting on a P2 with linux-2.5.10
In-Reply-To: <4175.1019767657@www13.gmx.net>
Message-ID: <Pine.LNX.4.33L2.0204251354000.10911-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2002 gjwucherpfennig@gmx.net wrote:

| It would be great if someone would set up an automated stress tester that
| will test each kernel before release, so that kernel developers and bug
| hunters can concentrate on the really important issues.

OSDL's STP (Scalable Test Platform) often runs thru a set of
tests on released and pre-released kernels.

However, like you say, some of those 2.5.x kernels just won't
compile without some external patches...and if the external
patches are available, we'll be able to handle that soon.

Full coverage will still be difficult...some drivers etc.
don't compile due to kernel API changes.
Some drivers break when loading, like IDE in your case,
and we don't have many IDE drives here.
I'm sure that we could come up with other coverage
problems^W challenges, but lots of them can be overcome.

We haven't reached the point of being a go/no-go decider
(that I know of).

-- 
~Randy

