Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268360AbTBSLdR>; Wed, 19 Feb 2003 06:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268362AbTBSLdR>; Wed, 19 Feb 2003 06:33:17 -0500
Received: from vsmtp1.tin.it ([212.216.176.221]:44224 "EHLO smtp1.cp.tin.it")
	by vger.kernel.org with ESMTP id <S268360AbTBSLdQ>;
	Wed, 19 Feb 2003 06:33:16 -0500
Date: Wed, 19 Feb 2003 12:41:44 +0100
From: Simone Piunno <pioppo@ferrara.linux.it>
To: Adam Belay <ambx1@neo.rr.com>, "Grover, Andrew" <andrew.grover@intel.com>,
       Shawn Starr <shawn.starr@datawire.net>,
       LinuxKernelMailingList <linux-kernel@vger.kernel.org>,
       Grover@unaropia.abulafia.casa
Subject: Re: 2.5.xx ACPI/Sb16 IRQ conflict
Message-ID: <20030219114144.GA25407@ferrara.linux.it>
References: <F760B14C9561B941B89469F59BA3A84725A18B@orsmsx401.jf.intel.com> <20030218224254.GE25172@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218224254.GE25172@neo.rr.com>
User-Agent: Mutt/1.4i
Organization: Ferrara LUG
X-Operating-System: Linux 2.4.20-skas3
X-Message: GnuPG/PGP5 are welcome
X-Key-ID: 860314FC/C09E842C
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 10:42:54PM +0000, Adam Belay wrote:

> > > From: Shawn Starr [mailto:shawn.starr@datawire.net] 
> > > I can confirm this with 2.5.61 and my SB16AWE card. There

> > There should have been a previous line about LNKD, listing possible
> > interrupts for it -- what did that line say?
> 
> On my copy of Shawn's dmesg I see the following:

I'd like to help with my sb16, bu neither OSS nor ALSA do compile on
2.5.62 :(

sound/oss/sb_card.c: In function `activate_dev':
sound/oss/sb_card.c:744: structure has no member named `active'
sound/oss/sb_card.c:747: structure has no member named `activate'
sound/oss/sb_card.c:750: structure has no member named `deactivate'
[...]

sound/isa/sb/sb16.c: In function `snd_sb16_isapnp':
sound/isa/sb/sb16.c:279: warning: implicit declaration of function
`isapnp_find_dev'
sound/isa/sb/sb16.c:279: warning: assignment makes pointer from integer
without a cast
sound/isa/sb/sb16.c:280: structure has no member named `active'
sound/isa/sb/sb16.c:293: structure has no member named `prepare'
[...]

Regards,
Simone

-- 
 Simone Piunno -- http://members.ferrara.linux.it/pioppo 
.-------  Adde parvum parvo magnus acervus erit  -------.
 Ferrara Linux Users Group - http://www.ferrara.linux.it 
 Deep Space 6, IPv6 on Linux - http://www.deepspace6.net 
 GNU Mailman, Mailing List Manager - http://www.list.org 
`-------------------------------------------------------'
