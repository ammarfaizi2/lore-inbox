Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132519AbQKXJW2>; Fri, 24 Nov 2000 04:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132517AbQKXJWS>; Fri, 24 Nov 2000 04:22:18 -0500
Received: from mehl.gfz-potsdam.de ([139.17.1.100]:57048 "EHLO
        mehl.gfz-potsdam.de") by vger.kernel.org with ESMTP
        id <S132285AbQKXJWG>; Fri, 24 Nov 2000 04:22:06 -0500
Date: Fri, 24 Nov 2000 09:52:00 +0100
From: Steffen Grunewald <steffen@gfz-potsdam.de>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.2.16: How to freeze the kernel
Message-ID: <20001124095200.H4339@dss19>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <3A1E309C.26058.40EA98@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <3A1E309C.26058.40EA98@localhost>
X-Disclaimer: I'm still testing mutt ...
X-Operating-System: SunOS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2000-11-24 (09:10), Ulrich Windl wrote:
> Hello,
> 
> At that point I pressed "RESET", and interestingly the builtin BIOS of 
> the Adaptec 2740 (EISA) hung while trying to detect the device.
> 
> Only after powering down both, the CD writer and the machine (a HP 
> Netserver LD Pro), the BIOS detected the device again. So I guess 
> something badly hung...

For bad sector management I use an old EISA 486 also equipped with
a 2740 card, this one show the same behaviour when I run scsifmt
under DOS and get an old drive with incorrect termination or a bad
controller. Have to switch everything off, even the RESET switch
won't help. I'd blame the BIOS only.

BTW, the built in SCSI utilities are buggy - one cannot rescan the bus...

Are there still upgrades (EISA is meant to be upgradeable) floating
around?

Steffen
-- 
Steffen Grunewald ** GeoForschungsZentrum  Potsdam ** Projektbereich 2.2
Telegrafenberg E3 ** D-14473  Potsdam ** Germany / Duitsland / Allemagne
office: steffen(at)gfz-potsdam.de  **  home: steffen.grunewald(at)gmx.de
  Hi! I'm a .signature virus. Copy me to your sig and help me spread!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
