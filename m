Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264820AbTCEFQj>; Wed, 5 Mar 2003 00:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTCEFQj>; Wed, 5 Mar 2003 00:16:39 -0500
Received: from isdn245.s.netic.de ([212.9.162.245]:11401 "EHLO solfire")
	by vger.kernel.org with ESMTP id <S264820AbTCEFQe>;
	Wed, 5 Mar 2003 00:16:34 -0500
Date: Wed, 05 Mar 2003 06:15:58 +0100 (MET)
Message-Id: <20030305.061558.74750788.mccramer@s.netic.de>
To: matthias.andree@gmx.de
Cc: linux-kernel@vger.kernel.org
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <20030305024446.GA13870@merlin.emma.line.org>
References: <20030305024446.GA13870@merlin.emma.line.org>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
X-SA-Exim-Rcpt-To: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: IDE DMA/VIA woes on SuSE 2.4.19-167
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Andree <matthias.andree@gmx.de>
Subject: IDE DMA/VIA woes on SuSE 2.4.19-167
Date: Wed, 5 Mar 2003 03:44:46 +0100

Hi,

 ..."similiar" here:

 CDRW: Plextor 48/24/10
 Linux 2.4.20
 EPoX 8K5A3+ (VIA KT333)

 Copying the contents of CD is VERY SLOW...

 Copying a CD is more worst than a CDRW of comparable contents.

 ....sigh

 Keep Hacking!
 Meino

> Hi,
> 
> I have some issues here:
> 
> Plextor PX-W4824TA 1.03 as hdc (no hdd)
> VIA KT133
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
>         Flags: bus master, medium devsel, latency 32
>         I/O ports at ffa0 [size=16]
>         Capabilities: [c0] Power Management version 2
> 
> When I try to enable DMA (hdparm -d1 or hdparm -d1 -X66), hdparm -tT
> chokes, SuSE k_athlon-2.4.19-167. FreeBSD-5 (with atapicam) is fine and
> uses UDMA33.
> 
> SuSE's kernel seems to be fine on a different hardware (VIA KT333 +
> Toshiba SD-M1612).
> 
> I've tried 2.4.21-pre5 which crashes on boot, I haven't yet been able to
> go fishing for the Ooops and decode it (I have serial console here, so
> it's just a matter of finding the time to do that).
> 
> ide-scsi makes no difference (not that I had expected that).
> 
> Which kernel version should I try next before thinking about this for
> longer?
> 
> -- 
> Matthias Andree
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
