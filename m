Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVIDGyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVIDGyI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 02:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVIDGyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 02:54:07 -0400
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:13760 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S1751268AbVIDGyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 02:54:06 -0400
From: Paul Misner <paul@misner.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Brand-new notebook useless with Linux...
Date: Sun, 4 Sep 2005 01:53:57 -0500
User-Agent: KMail/1.8.2
References: <200509031859_MC3-1-A720-F705@compuserve.com>
In-Reply-To: <200509031859_MC3-1-A720-F705@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509040153.57751.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 September 2005 5:58 pm, Chuck Ebbert wrote:
> I just bought a new notebook.  Here is the output from lspci using the
> latest pci.ids file from sourceforge:
>
...
> controller: Broadcom Corporation BCM4318 [AirForce One 54g] 802.11g
> Wireless LAN Controller (rev 02) 05:09.0 CardBus bridge: Texas Instruments
> 05:09.4 Class 0805: Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621,
> PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller
>
> None of these work and I can find no support anywhere for them:
>
> SMBus
> Audio ("unknown codec")
> Modem ("no codec available")
> Wireless
> FlashMedia
> SD/MMC
>
> Additionally, the system clock runs at 2x normal speed with PowerNow
> enabled.
>
> Am I stuck with running XP on this thing?
>
> __
> Chuck
> -

You already had an answer on the audio.  Your answer on the wireless is 
ndiswrapper.  You should really be looking at the Linux r3000 list, which 
handles much more than that now.  The information for that list is:

LinuxR3000 mailing list
LinuxR3000@lists.pcxperience.com
http://lists.pcxperience.com/cgi-bin/mailman/listinfo/linuxr3000
Wiki at http://prinsig.se/weekee/

If those folks don't know how to make you notebook run, you are in serious 
trouble.  I have a Compaq R3120US, which I learned how to set up from the 
people over there.  Notebooks are very different from most other computers, 
and you can expect to take some extra time and effort to get one set up.

An important note about your wireless is that even with ndiswrapper, not all 
Windows drivers are created equal, and you may need to try several for the 
same chip from different sources to find one that works.

Good luck with your SD/MMC reader, that tends to be something that doesn't 
work under Linux because the manufacturers haven't released the information 
needed to create proper drivers for them.

Mandriva tends to work great on notebooks, once you install the proper 
wireless driver, I have had good luck with Mepis as well, and I know many 
people running Fedora as well.  Your other big challenge, maybe the biggest 
one, is going to be the display, at least if you have an uncommon display 
like the 1280 X 800 on my notebook.

Paul
