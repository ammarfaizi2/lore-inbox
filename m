Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317848AbSGVSUP>; Mon, 22 Jul 2002 14:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317850AbSGVSUO>; Mon, 22 Jul 2002 14:20:14 -0400
Received: from ns.suse.de ([213.95.15.193]:21510 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317848AbSGVSUM>;
	Mon, 22 Jul 2002 14:20:12 -0400
Date: Mon, 22 Jul 2002 19:20:54 +0200
From: Dave Jones <davej@suse.de>
To: Clemens Schwaighofer <cs@pixelwings.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.27-dj1
Message-ID: <20020722192054.O27749@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Clemens Schwaighofer <cs@pixelwings.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020721215845.GA23019@suse.de> <1340522704.1027338950@[192.168.1.172]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1340522704.1027338950@[192.168.1.172]>; from cs@pixelwings.com on Mon, Jul 22, 2002 at 01:55:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 01:55:50PM +0200, Clemens Schwaighofer wrote:
 > I just tried it on my test system (Redhat 7.3 with gcc-3.1-9 from rawhide) 
 > and I get this
 > fs/fs.o(.text+0x27f66): undefined reference to `jiffies_64_to_clock_t'
 > fs/fs.o(.text+0x297fb): undefined reference to `jiffies_64_to_clock_t'
 > fs/fs.o(.text+0x29877): undefined reference to `jiffies_64_to_clock_t'

See the post from Tim Schmielau in this thread, and apply the patch there.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
