Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbRDPR2V>; Mon, 16 Apr 2001 13:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRDPR2K>; Mon, 16 Apr 2001 13:28:10 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:49419 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S131644AbRDPR2F>; Mon, 16 Apr 2001 13:28:05 -0400
Message-ID: <3ADB2B99.EB0C3E28@damncats.org>
Date: Mon, 16 Apr 2001 13:27:53 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac7
In-Reply-To: <E14p860-00008u-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> VIA users should test this kernel carefully. It has what are supposed to be
> the right fixes for the VIA hardware bugs. Obviously the right fixes are not
> as tested as the deduced ones.
> 
> 2.4.3-ac7
> o       Updated VIA quirk handling for the chipset      (Andre Hedrick,
>         flaws                                            George Breese)
>         | Experimental version removed
>         | VIA users should check this kernel -carefully-!!!!

I tried it on my dual P3 box with the VIA chipset and I'm definitely
getting timeouts for the USB devices. Booting with "noapic" resolves the
problem for me. Output of lspci for the VIA stuff is:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev
c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO]
(rev 23)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 11)
00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050 (rev
30)

The motherboard is a Tyan Tiger 133 (slot 1).

I'd be happy to provide more info, just tell me what you need.

Thanks,
John
