Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267152AbSLKO0H>; Wed, 11 Dec 2002 09:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbSLKO0H>; Wed, 11 Dec 2002 09:26:07 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:43994 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267152AbSLKO0F>; Wed, 11 Dec 2002 09:26:05 -0500
Date: Wed, 11 Dec 2002 07:26:50 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Stian Jordet <liste@jordet.nu>, Allan Duncan <allan.d@bigpond.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.51
In-Reply-To: <m1smx4vrem.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0212110720540.2617-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How well does this driver work if you don't have a firmware
> driver initialize the card? aka a pci option ROM.
>
> I am interested because with LinuxBIOS it is still a pain to run
> PCI option roms, and I don't necessarily even have then if it a
> motherboard with video.  There are some embedded/non-x86 platforms
> with similar issues.
>
> My primary interest is in the cheap ATI Rage XL chip that is on many
> server board. PCI Vendor/device  id 1002:4752 (rev 27) from lspci.
>
> If nothing else if some one could point me to some resources on
> how to get the appropriate documentation from the video chipset
> manufacturers I would be happy.
>
> But I did want to at least point that running a system with out bios
> initialized video was certainly among the cases that are used.

Unfortunely ATI doesn't like to release info on what needs to be done to
initialize without frimware. I really wish this was the case. I did see
email back about someone getting a mach64 card working without firmware.
They used a bus analysiser to do this. I will see what kind of patches I
can dig up.


