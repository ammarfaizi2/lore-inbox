Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbSI2Sod>; Sun, 29 Sep 2002 14:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSI2Sod>; Sun, 29 Sep 2002 14:44:33 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:52104 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261719AbSI2Soc>;
	Sun, 29 Sep 2002 14:44:32 -0400
Date: Sun, 29 Sep 2002 19:52:28 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Matt Domsch <Matt_Domsch@Dell.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Message-ID: <20020929185228.GB28028@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Russell King <rmk@arm.linux.org.uk>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Matt Domsch <Matt_Domsch@Dell.com>, linux-kernel@vger.kernel.org
References: <20020929161144.GA19948@suse.de> <Pine.LNX.4.44.0209291315010.28578-100000@chaos.physics.uiowa.edu> <20020929192758.D15924@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929192758.D15924@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 07:27:58PM +0100, Russell King wrote:

 > The ARM port used to have arch/arm/drivers/{block,char,net,sound} but
 > this was decried by _other_ people in the ARM community to be too
 > painful, and I was literally hounded into moving them into drivers.
 > 
 > I don't want to go back to arch/arm/drivers now, thanks.

Out of curiousity, why was this considered painful ?
Not that I change my original proposition of disinfecting
arch/i386/kernel/  Rather than proposing to set a standard
for all arch's to conform to, I had the sole intention of
trying to cut down some of the growth in that dir by factoring
out the more common things (which were CPU drivers)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
