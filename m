Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWGHIuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWGHIuz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 04:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWGHIuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 04:50:55 -0400
Received: from sorrow.cyrius.com ([65.19.161.204]:49169 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1750824AbWGHIuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 04:50:54 -0400
Date: Sat, 8 Jul 2006 10:50:52 +0200
From: Martin Michlmayr <tbm@cyrius.com>
To: Andi Kleen <ak@suse.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, 341801@bugs.debian.org,
       asd@suespammers.org, kevin@sysexperts.com
Subject: Re: skge error; hangs w/ hardware memory hole
Message-ID: <20060708085052.GF5635@deprecation.cyrius.com>
References: <20060703205238.GA10851@deprecation.cyrius.com> <20060707141843.73fc6188@dxpl.pdx.osdl.net> <200607072328.51282.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607072328.51282.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@suse.de> [2006-07-07 23:28]:
> Is that a board with VIA chipset?

Yes, according to lspci, there's a VIA K8T800Pro and VT8237.


0000:00:00.0 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.1 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.2 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.3 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.4 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:00.7 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South] (prog-if 00 [Normal decode])
0000:00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
-- 
Martin Michlmayr
http://www.cyrius.com/
