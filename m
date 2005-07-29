Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVG2RB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVG2RB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVG2RB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:01:59 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:51584 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262619AbVG2RBy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:01:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JxsJ6z5gzoGudC877Cychal8sE6BaAP7y4G66td6Vf3fg6oACUrTSulk4iudqUjwtV6XErOj83cV6kdYxt0f4MOmz5jJIIzI9NI0QwneC6GhkmvhF5QZTvBjLPKMEWqCZBmw+WVldBSDYl/7HfIVYEeq1yNsvIdHlGXJ7xw8AAE=
Message-ID: <5786143705072910011b280f67@mail.gmail.com>
Date: Fri, 29 Jul 2005 12:01:26 -0500
From: Jesus Delgado <jdelgado@gmail.com>
Reply-To: Jesus Delgado <jdelgado@gmail.com>
To: Brad Barnett <bahb@l8r.net>
Subject: Re: Acer Aspire 1691WCLi no boot problem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050729122015.73165b54@be.back.l8r.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050729122015.73165b54@be.back.l8r.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

  Iam have is the same problems with emachines M6807.

 Any Idea?

On 7/29/05, Brad Barnett <bahb@l8r.net> wrote:
> 
> 
> 
> Hey,
> 
> I have a very odd problem with an Acer Aspire 1691WCLi.  This laptop will
> simply not boot with any Debian precompiled kernel, with the exception of
> Debian's 2.4.27-2 initrd kernel.  I have compiled my own kernels, using a
> vast array of options, 2.6.11, 2.6.12, 2.6.12.3, 2.6.13-rc4 and 2.4.27,
> they also all fail in exactly the same way.  I have tried with and without
> initrd, acpi, 386 or other processor options, as well as very lean,
> stripped down kernels.  I have tried with both lilo and grub, but both
> result in the same hang.
> 
> Lilo or grub boots the kernel, and I see the classic:
> 
> boot: vmlinuz
> Loading vmlinuz.................................................
> BIOS data check successful
> Uncompressiong Linux... Ok. booting the kernel.
> _
> 
> 
> That's it.  A screencap can be had here, although it does not tell much else:
> 
> http://be.back.l8r.net:8000/no_boot.jpg
> 
> Debian's 2.4.27-2 boots fine, and this is what really annoys me.  I took
> Debian's 2.4.27-2 initrd config from /boot, ran make oldconfig on a fresh
> 2.4.27 tree (some minor options were different due to Debian's
> backpatching).  This image _still_ would not boot.
> 
> Does anyone have any suggestions?  If needed, I could compile a few more
> kernels, change GCC versions (if anyone thinks that would help) and so on.
>  However, my goal here is to get 2.6 working in order to support various
> bits of hardware on this laptop.
> 
> There are very few bios options to change. :/
> 
> Pentium M 725, 512M ram.
> 
> LSPCI shows:
> 
> 0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
> 0000:00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML ExpressGraphics Controller (rev 03)
> 0000:00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03)
> 0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04)
> 0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04)
> 0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 04)
> 0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04)
> 0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04)
> 0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04)
> 0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04)
> 0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04)
> 0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
> 0000:00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
> 0000:00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller (rev 04)
> 0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)
> 0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04)
> 0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
> 0000:06:01.0 CardBus bridge: Texas Instruments Texas Instruments PCIxx21/x515 Cardbus Controller
> 0000:06:01.2 FireWire (IEEE 1394): Texas Instruments Texas Instruments OHCI Compliant IEEE 1394 Host Controller
> 0000:06:01.3 Unknown mass storage controller: Texas Instruments Texas Instruments PCIxx21Integrated FlashMedia Controller
> 0000:06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
> 0000:06:08.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788 Gigabit Ethernet(rev 03)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
