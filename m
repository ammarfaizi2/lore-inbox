Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272703AbRILIWv>; Wed, 12 Sep 2001 04:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272706AbRILIWm>; Wed, 12 Sep 2001 04:22:42 -0400
Received: from [212.169.100.200] ([212.169.100.200]:33789 "EHLO
	bigboss.nextframe.net") by vger.kernel.org with ESMTP
	id <S272703AbRILIW1>; Wed, 12 Sep 2001 04:22:27 -0400
Date: Wed, 12 Sep 2001 10:21:44 +0200
From: Morten Helgesen <admin@nextframe.net>
To: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  Duron kernel crash (i686 works)
Message-ID: <20010912102144.J2858@bigboss>
Reply-To: admin@nextframe.net
In-Reply-To: <Pine.GSO.4.21.0109111623500.13708-100000@jacui> <Pine.GSO.4.21.0109120954380.20914-100000@skiathos.physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0109120954380.20914-100000@skiathos.physics.auth.gr>; from "kostas@skiathos.physics.auth.gr" on Wed, Sep 12, 2001 at 09:56:00AM
X-Editor: VIM - Vi IMproved 5.7
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 3R BIOS includes the following changes :

1. Update BIOS code.
2. Enhance ISA PnP compatibility.
3. Enhance SCSI adapters compatibility.
4. Add 1400(133) Athlon support for KT7A/KT7A-RAID.
5. Add new option "1200 above" for high speed Athlons
   with 100FSB. KT7 / KT7-RAID / KT7A / KT7A-RAID / KT7E only support
   1.4G(100) Athlon with L1 bridges disconnected. Check L1 before
   you buy a CPU please!
6. For Creative SBLive 5.1 sound card users, you may try these
   options while experience sound quality issue.
   * PCI master read caching, default setting=Disabled
   * PCI master time-out, Default setting=1
   Setting above options to Disabled/3 will lead to the same result
   with VIA Latency patch V0.14 and may help SB Live 5.1 sound
   issue. If the system experiences low performance after these
   settings, enable the "PCI master read caching" please.
7. Enhance the high speed 133FSB Athlon stability for KT7A/KT7A-RAID.
8. HPT 370 RAID BIOS version 1.11.0402 for KT7-RAID/KT7A-RAID.
   This BIOS version is also for non RAID boards and HPT BIOS will
   be automatically disabled while RAID controller chip not detected.

I must admit that these specifications weren`t exactly the most technical I have
ever seen, but anyway ... taken from : http://fae.abit.com.tw/eng/download/bios/kt7.htm

On Wed, Sep 12, 2001 at 09:56:00AM +0300, Liakakis Kostas wrote:
> On Tue, 11 Sep 2001, Roberto Jung Drebes wrote:
> 
> > As said earlier, this happens after upgrading from BIOS YH to 3R in the
> > KT7A-RAID. The processor is a Duron 800 not overclocked.
> 
> What exactly did the new bios version change? 
> Enabled STPGNT by any chance?
> 
> -K.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



== Morten

-- 
mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
