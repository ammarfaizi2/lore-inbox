Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291146AbSBGNVt>; Thu, 7 Feb 2002 08:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291143AbSBGNVk>; Thu, 7 Feb 2002 08:21:40 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:36623 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S291151AbSBGNVb>; Thu, 7 Feb 2002 08:21:31 -0500
Date: Thu, 7 Feb 2002 14:20:55 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: status on northbridge disconnection apm saving?
In-Reply-To: <Pine.LNX.4.40.0202070848450.14773-100000@hades.uni-trier.de>
Message-ID: <Pine.LNX.4.44.0202071417050.1378-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Daniel Nofftz wrote:

> On Thu, 7 Feb 2002, Rasmus Bøg Hansen wrote:
> 
> > I just flashed my BIOS today (upgrading my Asus A7V133-C from BIOS
> > rev. 1005A to rev. 1007). Suddenly I begin to experience the sound-skips
> > reported by other people. The CPU is a TB (9x133, 1200MHz, family 6,
> > model 4, stepping 2).
> >
> > Before flashing I had no trouble at all and the CPU cooled just fine, so
> > it might not only be a chipset issue.
> >
> > I tried the new version of the patch and get:
> 
> > Athlon/Duron CLK_Ctrl Value found : fff0d22f
> > Athlon/Duron CLK_Ctrl Value set to : fff0d22f
> 
> ahh ... the value already was set ... ok ... that means that this value is
> not the right one for this cpu. i got some new informations which say that
> you need different values for different cpus ... at the moment i wait
> for an answer from amd. i send them an email and asked for some support on
> this toppic. maybe i get the table withe the right settings.
> until then i see no way to get further ... so we must wait what their
> answer is ...

I now fiddled a little with the PCI settings in the BIOS...

When 'PCI master read cahing' is enabled everything works fine (sound 
works, cooling works. When disabled I get sound skips. The above flags 
are exactly the same:

Athlon/Duron CLK_Ctrl Value found : fff0d22f
Athlon/Duron CLK_Ctrl Value set to : fff0d22f
Enabling disconnect in VIA northbridge: KT133/KX133 chipset found

As I think i noted earlier, my motherboard is KT133A-based.

My system functions perfectly stable with the 'PCI master read caching' 
enabled - I have no idea whether this is true in general.

Regards
Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
Is there anything else I can contribute?
The latitude and longtitude of the bios writers current position, and
a ballistic missile.
                                                          -- Alan Cox
----------------------------------[ moffe at amagerkollegiet dot dk ] --

