Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282123AbRK1KvA>; Wed, 28 Nov 2001 05:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282125AbRK1Kuu>; Wed, 28 Nov 2001 05:50:50 -0500
Received: from [212.65.238.182] ([212.65.238.182]:47375 "EHLO
	trebo3.chemoprojekt.cz") by vger.kernel.org with ESMTP
	id <S282123AbRK1Kuj>; Wed, 28 Nov 2001 05:50:39 -0500
Message-ID: <35E64A70B5ACD511BCB0000000004CA10BD4FA@NT_CHEMO>
From: PVotruba@Chemoprojekt.cz
To: nakai@neo.shinko.co.jp, Sven.Riedel@tu-clausthal.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.14 Oops during boot (KT133A Problem?)
Date: Wed, 28 Nov 2001 11:50:32 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	the memory check in bios is designed mostly for testing if (detected
memory chips == present memory chips).
	Safe comprehensive checking can be done by memtest86, and virtualy
unsafe testing can be cyclic kernel compilation (if you notice strange
compile errors at same kernel config but at different moments, you can
suspect that your hardware is rotten). 

	To: Sven
	are you sure that ALL your memory chips are bad? how about memory
latency and other bios settings, overclocking, etc.? try to setup your box
to run at slowest memory configuration as possible. It's hard to believe
that all of your chips are gone. 

	Regards
	Petr

	----- previous message follows:
> Congratulations!
> 
> Sven.Riedel@tu-clausthal.de wrote:
> > Well, the problem got solved (although not in a way I'd consider
> > satisfactory). After my machine started random segfaulting the day
> > before yesterday, I memcheck86'ed it again (the last check is a mere two
> > months ago), and lo - all three RAM chips were broken. Unfortunately, I
> > discovered this, after this broken RAM caused my /usr partition to go
> > fubar, resulting in me spending yesterday with a nice little reinstall.
> > After the reinstall, 2.4.14 booted fine off the harddisk. No more
> > oopses.
> 
> During this holidays, I guessed, and I thought it because of
> harddisk or PCI chip erro. Memory error! Was it found when booting
> matherboard by BIOS? I think motherboard always check memories when
> booting.  
> 
> -- 
> -=-=-=-=  SHINKO ELECTRIC INDUSTRIES CO., LTD.           =-=-=-=-
> =-=-=-=-    Core Technology Research & Laboratory,       -=-=-=-=
> -=-=-=-=      Infomation Technology Research Dept.       =-=-=-=-
> =-=-=-=-  Name:Hisakazu Nakai          TEL:026-283-2866  -=-=-=-=
> -=-=-=-=  Mail:nakai@neo.shinko.co.jp  FAX:026-283-2820  =-=-=-=-
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
