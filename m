Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261827AbRFFLij>; Wed, 6 Jun 2001 07:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbRFFLi3>; Wed, 6 Jun 2001 07:38:29 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:18060 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S261827AbRFFLiO>;
	Wed, 6 Jun 2001 07:38:14 -0400
Date: Wed, 6 Jun 2001 13:36:57 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Glenn Shannon <glenn@gecpalau.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Lockup in 2.4.5-ac2
In-Reply-To: <01060610004000.00930@metukerdelong>
Message-ID: <Pine.LNX.4.21.0106061335090.15060-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Glenn Shannon wrote:

> Hi all!
> 
> Enjoying the -ac2 kernel except for one minor thing: it locks up.

As I see below you have a Realtek 8139B...
The 8139too driver in 2.4.3-something to 2.4.5-ac2 is broken. It will hang
your machine. so upgrade to 2.4.5-ac3 or above (2.4.5-ac9 is the latest
right now)

/Martin



> Problem occurs whenever large amounts of data are transferred across the 
> network. This includes web pages, iso cd images, and compressed files.
> 
> I can transfer large amounts of data from the internet and to the internet 
> however.
> 
> It is a hardlock, I cannot even get the SysRq key to help me out.
> 
> System specs:
> 
> P-III 550
> 256MB RAM (1 DIMM)
> Abit SH6 (i815 based) Motherboard
> Using onboard Video/Audio
> Kernel 2.4.5-ac2
> Debian GNU/Linux 2.2rev3
> Realtek 8139B (see attached dmesg.output file)
> 10BaseT Network with 128K Satellite link to outside world
> 
> Tried protocols:
> Samba
> FTP
> HTTP
> NFS
> 
> If you need any more info let me know.
> 
> Thanks!
> 
> Glenn Shannon
> Systems Administrator
> Gibbons Enterprises Corporation, Palau
> glenn@gecpalau.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Linux hackers are funny people: They count the time in patchlevels.

