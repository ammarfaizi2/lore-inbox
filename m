Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287711AbSAACMi>; Mon, 31 Dec 2001 21:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287714AbSAACM2>; Mon, 31 Dec 2001 21:12:28 -0500
Received: from [64.169.83.2] ([64.169.83.2]:13428 "EHLO mail.get2chip.com")
	by vger.kernel.org with ESMTP id <S287711AbSAACMT>;
	Mon, 31 Dec 2001 21:12:19 -0500
Message-ID: <3C311B00.FFB58648@get2chip.com>
Date: Mon, 31 Dec 2001 18:12:16 -0800
From: ccroswhite@get2chip.com
Reply-To: ccroswhite@get2chip.com
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Dual athlon XP 1800 problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having problems with dual athlons and more than 512M RAM.  I have
compiled several kernels with either ATHLON, 1386, i686 support with the
same affect, I get a kernel that will fail to boot properly.  Sometimes
I get a kernel panic that outs to kdb, sometimes I get a freeze, and
sometimes I get failed to mount root partition, but never has this
kernel successfully come up.  I am quite certain it is not the memory or
the system ( I can get windblows 2k to run successfully with upto 3.5G
RAM).

Here is the configuration:

Tyan S2460
Dual Athlon XP 1800
512M DDR DIMMS (also used 128, 256, and 1G)
Western Digital 20G Drive

Kernels 2.4.9, 2.4.16, 2.4.17, 2.5.2
    configured for 4G
    configured as 1386, 1686, and Athlon processor support
    configured with XFS support
    configured with kdb support

Is there a patch for this?  Am I configuring something wrong in the
kernel?

TIA
Chris Croswhite

