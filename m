Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTBET4D>; Wed, 5 Feb 2003 14:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbTBET4D>; Wed, 5 Feb 2003 14:56:03 -0500
Received: from poup.poupinou.org ([195.101.94.96]:8244 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S264644AbTBET4B>;
	Wed, 5 Feb 2003 14:56:01 -0500
Date: Wed, 5 Feb 2003 21:05:21 +0100
To: Pavel Machek <pavel@ucw.cz>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, ducrot@poupinou.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Message-ID: <20030205200521.GN1205@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com> <20030204221003.GA250@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204221003.GA250@elf.ucw.cz>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 11:10:04PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This patch is for s4bios support in 2.5.59 with acpi-20030123.
> > > 
> > > This is the 'minimal' requirement.  Some devices (especially the
> > > IDE part) are not well resumed.  Handle with care..
> > > 
> > > Note also that the resuming part (I mean IDE) was more stable
> > > with an equivalent patch when I tested with 2.5.54 (grumble 
> > > grumble)...
> > > 
> > > I think also that it is a 'good' checker for devices power management
> > > in general...
> > 
> > I'd really rather just have S4OS (aka swsusp) in 2.5 patches -- if the
> > OS can do S4 on its own, that is really preferable to S4bios.
> 
> Well, we already have S4OS, and having S4OS does not mean we can't
> have S4bios.
> 
> Some people apparently want slower suspend/resume but have all caches
> intact when resumed. Thats not easy for swsusp but they can have that
> with S4bios. And S4bios is usefull for testing device support; it
> seems to behave slightly differently to S3 meaning better testing.
> 

Yep, correct.  The problem is that now I have more trouble with s4bios
in general with 2.5.  That worked more reliability with 'older' 2.5 series.
Really don't know why.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
