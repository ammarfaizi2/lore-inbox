Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSLXMp4>; Tue, 24 Dec 2002 07:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSLXMp4>; Tue, 24 Dec 2002 07:45:56 -0500
Received: from zork.zork.net ([66.92.188.166]:32440 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S261581AbSLXMpz>;
	Tue, 24 Dec 2002 07:45:55 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Crash with 3c59x.o
References: <20021224123341.GA22985@kiwi.hjbaader.home>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: BRAZEN SELF-DECEIT, MISMATCHED
 PARENTHESES
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 24 Dec 2002 12:54:05 +0000
In-Reply-To: <20021224123341.GA22985@kiwi.hjbaader.home> (Hans-Joachim
 Baader's message of "Tue, 24 Dec 2002 13:33:45 +0100")
Message-ID: <6uu1h3pogi.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Hans-Joachim Baader quotation:

> lspci:
> 00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
> 00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
> 00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
> 00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
> 00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
> 00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
> 00:0b.0 Serial controller: NetMos Technology 222N-2 I/O Card (2S+1P) (rev 01)
> 00:0f.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
> 00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 01)
> 00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 01)
>
> As you can see, there are two 3Com cards which are both recognized by the
> driver.

Possibly this is not what you meant, but lspci output does not
indicate whether a PCI device has been recognised by a driver or not.
You would need to check e.g. dmesg output or ifconfig -a after loading
the driver module to verify that it sees both cards.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
