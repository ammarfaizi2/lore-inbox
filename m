Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbSAVGil>; Tue, 22 Jan 2002 01:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287711AbSAVGic>; Tue, 22 Jan 2002 01:38:32 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:30307 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S280588AbSAVGi2>; Tue, 22 Jan 2002 01:38:28 -0500
Message-ID: <3C4D0784.40802696@randomlogic.com>
Date: Mon, 21 Jan 2002 22:32:36 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Random Logic
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Athlon PSE/AGP Bug
In-Reply-To: <E16SkGH-0000Ut-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > That errata lists all Athlon Thunderbirds as affected and all Athlon
> > Palominos except for stepping A5.
> >
> > Regardless of specific errata listings, will future workarounds be
> > enabled based on cpuid or via a test for the bug itself?
> 
> That problem shouldnt be hitting Linux x86. I don't know about the
> Nvidia module but the base kernel shouldnt hit an invlpg on 4Mb pages
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

See my post on /. regarding the bug.

In summary, I have 2 Thunderbird systems - a dual 1.4GHz Thunderbird on
Tyan Thunder K7 and a single 1.4GHz Thunderbird on Asus A7V133 - with
NVIDIA cards and the latest 2313 NVIDIA driver. The single runs RH 7.2
and this one (the dual) an up2date RH 7.1 with kernel 2.4.17. I have no
problems unless I boot a system into Win98. There are many other issues,
as you all know (and many dorks on /. apparently do not), that can and
will cause a system to hang. I run AGP4x, SBA, FSAA, and Anisotropic
filtering on most all games. I compile often many different things. The
ONLY times I have compile issues are when I compile some things (Torque
game engine and Quake II) with -march at anything over pentium, at which
point either the internal compiler bugs rear their ugly heads or I get
strange graphics in a game.

But since kernel 2.4.14, never a system lock.

PGA
-- 
Paul G. Allen
Owner, Sr. Engineer, Security Specialist
Random Logic/Dream Park
www.randomlogic.com
