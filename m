Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268769AbUHLUiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268769AbUHLUiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbUHLUiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:38:11 -0400
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:1926 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268769AbUHLUhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:37:54 -0400
Date: Thu, 12 Aug 2004 22:37:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nathan Bryant <nbryant@optonline.net>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SCSI midlayer power management
Message-ID: <20040812203729.GE14556@elf.ucw.cz>
References: <411A1B72.1010302@optonline.net> <1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston> <1092314892.1755.5.camel@mulgrave> <20040812131457.GB1086@elf.ucw.cz> <1092328173.2184.15.camel@mulgrave> <20040812191120.GA14903@elf.ucw.cz> <1092339247.1755.36.camel@mulgrave> <20040812202622.GD14556@elf.ucw.cz> <1092342716.2184.56.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092342716.2184.56.camel@mulgrave>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes.
> 
> Well, that makes the suspend and resume functions rather complex. 
> They're not going to be coded simply if we have to save and restore the
> register state of the cards and reinitialise them.  I assume if you
> had

Can't you simply reuse bootup code? It will no longer be __init,
but it should make suspend/resume functions quite simple.

> to pick three drivers to do this for, that would be aic7xxx, aic79xx and
> sym_2?

No idea, only SCSI host I owned was some 8-bit isa thing....

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
