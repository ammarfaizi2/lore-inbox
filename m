Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261623AbSI2SWm>; Sun, 29 Sep 2002 14:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261676AbSI2SWl>; Sun, 29 Sep 2002 14:22:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11795 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261623AbSI2SWl>; Sun, 29 Sep 2002 14:22:41 -0400
Date: Sun, 29 Sep 2002 19:27:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Dave Jones <davej@codemonkey.org.uk>, Matt Domsch <Matt_Domsch@Dell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Message-ID: <20020929192758.D15924@flint.arm.linux.org.uk>
References: <20020929161144.GA19948@suse.de> <Pine.LNX.4.44.0209291315010.28578-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209291315010.28578-100000@chaos.physics.uiowa.edu>; from kai-germaschewski@uiowa.edu on Sun, Sep 29, 2002 at 01:20:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 01:20:44PM -0500, Kai Germaschewski wrote:
> Let me add that there are currently two places where arch specific drivers
> appear, eg:
> 
> 	arch/{cris,um}/drivers/
> and
> 	drivers/{s390,macintosh,acorn}/
> 
> I think it'd be nice to decide on one way or the other. The first place 
> has the advantage of putting all arch-specific stuff into one place, the 
> second one makes it (IMO) cleaner to share drivers between e.g. s390 and 
> s390x, or possibly i386/x86_64 in the future.

The ARM port used to have arch/arm/drivers/{block,char,net,sound} but
this was decried by _other_ people in the ARM community to be too
painful, and I was literally hounded into moving them into drivers.

I don't want to go back to arch/arm/drivers now, thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

