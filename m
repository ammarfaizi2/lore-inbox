Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267821AbTBYIcE>; Tue, 25 Feb 2003 03:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267826AbTBYIcE>; Tue, 25 Feb 2003 03:32:04 -0500
Received: from cliff.cse.wustl.edu ([128.252.166.5]:18905 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP
	id <S267821AbTBYIcC>; Tue, 25 Feb 2003 03:32:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15963.11083.807739.999724@samba.doc.wustl.edu>
Date: Tue, 25 Feb 2003 02:37:31 -0600
From: Krishnakumar B <kitty@cse.wustl.edu>
To: Peter Nome <peter@cogweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20, Athlon MP and Promise PDC20276 IDE controller
References: <1046160591.3e5b24cfb20de@webmail.cogweb.net>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 25 February 2003, Peter Nome wrote:
> 
> Hi Krishnakumar,
> 
> "Am I right in assuming that Linux doesn't enable DMA on this controller?
> How do I determine if DMA is enabled for a ide controller apart from
> relying on the boot message?"
> 
> As you suspect, you're getting DMA all right -- you see it in the boot
> message too, as UDMA(133). To confirm, issue
> 
> hdparm /dev/hde
> 
> Looks good!

Great ! It is good to hear. Do you know why my machine reboots every other
time (only when booting up; I haven't seen it reboot, once up and running)
when booting SMP kernels ? I tried using kernel-2.4.20 and it too exhibits
the same behaviour.

Is there some setting in BIOS that I got wrong ? I am not into any
overclocking business, as these are meant to be used by my prof and other
folks, who care a lot about a stable system than anything else.

Will using mem=nopentium solve the problem and is it the right fix ? Will
enabling/disabling ECC memory checking in the BIOS (the BIOS seems to do
this when I select "Load Optimized Defaults") affect it ?

I seem to be a loss at narrowing down the problem to a single component as
it seems to act according to it's own whims and fantasies. And the fact
that things work with a UP kernel, makes me feel that it is not a hardware
issue. Anyone else with the same hardware experience similar issues ?

Any help is appreciated.

Thanks,
kitty.
