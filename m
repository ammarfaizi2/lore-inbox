Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135213AbREJLzt>; Thu, 10 May 2001 07:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135594AbREJLzj>; Thu, 10 May 2001 07:55:39 -0400
Received: from www.topmail.de ([212.255.16.226]:32765 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S135213AbREJLzc>;
	Thu, 10 May 2001 07:55:32 -0400
Message-ID: <00a501c0d948$1c6b4a40$de00a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "Pavel Roskin" <proski@gnu.org>, "Pete Zaitcev" <zaitcev@redhat.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <200105100253.f4A2rsK305959@saturn.cs.uml.edu>
Subject: Re: Patch to make ymfpci legacy address 16 bits
Date: Thu, 10 May 2001 11:54:48 -0000
Organization: eccesys.net Linux development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When you write "the kernel", do you mean the driver or generic
> code? I hope you mean the driver, because I have this:
> 
> 1. the device looks normal at power on
> 2. the driver pokes a device-specific config register
> 3. the config space header changes from type 0 to type 1
> 
> (The class code does NOT indicate PCI-to-PCI bridge.
> You could say this is like CardBus but much weirder)
> 
> If the kernel saves type 1 header data, cuts power using
> motherboard features, restores power, and then tries to
> restore type 1 header data into a type 0 header... the
> system will be well and truly screwed IMHO.

This reminds me of being unable to use my sound card under Windoze
after stand-by, suspend etc. (NB Win2k hibernate worked, suspend
I had disabled then).
Seems as not only linux has this kind of problems...
I don't remember _which_ card it was but I am quite sure it was
an old OPTi MAD16 Pro.

-mirabilos
-- 
EA F0 FF 00 F0 #$@%CARRIER LOST

