Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288512AbSAQL11>; Thu, 17 Jan 2002 06:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288534AbSAQL1Q>; Thu, 17 Jan 2002 06:27:16 -0500
Received: from ns.suse.de ([213.95.15.193]:7695 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288512AbSAQL1F>;
	Thu, 17 Jan 2002 06:27:05 -0500
Date: Thu, 17 Jan 2002 12:27:04 +0100
From: Dave Jones <davej@suse.de>
To: David Weinehall <tao@acc.umu.se>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] getting rid of suser/fsuser for good, first part
Message-ID: <20020117122704.E22171@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	David Weinehall <tao@acc.umu.se>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020117091203.N5235@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020117091203.N5235@khan.acc.umu.se>; from tao@acc.umu.se on Thu, Jan 17, 2002 at 09:12:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 09:12:03AM +0100, David Weinehall wrote:
 > It is after all 2.5-time, and hence time for a spring-cleaning.
 > These files are still naughty (feel free to fix!):
 > 
 > arch/i386/kernel/mtrr.c

 This file in particular needs more than just a spring clean imo.
 As extra support was added for the different MTRR lookalikes,
 it got messier and messier until it turned into the goop we
 have now.  Doing a real cleanup on this has been on my TODO for
 months now. Hopefully I'll get around to it in the 2.5 timeframe.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
