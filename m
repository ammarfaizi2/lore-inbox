Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316622AbSEUV2b>; Tue, 21 May 2002 17:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316631AbSEUV2a>; Tue, 21 May 2002 17:28:30 -0400
Received: from [195.39.17.254] ([195.39.17.254]:15514 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316622AbSEUV20>;
	Tue, 21 May 2002 17:28:26 -0400
Date: Tue, 21 May 2002 23:26:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arndb@de.ibm.com>
Subject: Re: driverfs problem
Message-ID: <20020521212606.GB3050@elf.ucw.cz>
In-Reply-To: <200205171408.g4HE8tK65272@d12relay02.de.ibm.com> <Pine.LNX.4.33.0205200750490.820-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > - I'm not sure about how to name the device directories. I don't have anything
> > like a hierarchical structure (except for something like scsi devices behind
> > a channel device) but rather a flat list of up to 65536 devices that are 
> > accessed by a device number that was defined by the system administrator. 
> > Each device also has a control unit type, comparable to a PCI ID, and in the 
> > general case each device driver knows about one control unit type. A 
> > hypothetical system might have
> > - one console, control unit type 0x3215, device number 0x0000
> > - three network devices, control unit type  0x1732, devno 0x0100 to 0x0102
> > - 1024 storage devices, control unit type 0x3390, devno 0x1000 to 0x13ff
> 
> The control unit types are irrelevant at this point, as they dictate the 
> type of device. You want to accurately represent the physical layout of 
> the system. 

s390 is linux on the top of vm. Linux runs under vmware-kind of
machine.... Its difficult to talk about "physical".
								Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
