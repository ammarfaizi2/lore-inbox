Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSDZWkS>; Fri, 26 Apr 2002 18:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314393AbSDZWkR>; Fri, 26 Apr 2002 18:40:17 -0400
Received: from [195.63.194.11] ([195.63.194.11]:13067 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314389AbSDZWkQ>; Fri, 26 Apr 2002 18:40:16 -0400
Message-ID: <3CC9C8A9.2080109@evision-ventures.com>
Date: Fri, 26 Apr 2002 23:37:45 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andi Kleen <freitag@alancoxonachip.com>
CC: linux-kernel@vger.kernel.org, stephan@maciej.muc.de
Subject: Re: [BUG] 2.5.10 - kernel hangs after detecting CD/DVD ROM (was:
 Re: IDE problem:  2.5.10 compiles but hangs during boot)
In-Reply-To: <200204251757.07947.stephan@maciej.muc.de> <m3adrq6zxe.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Andi Kleen napisa?:
> Stephan Maciej <stephan@maciej.muc.de> writes:
> 
>>later
>>VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>>    ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
>>    ide1: BM-DMA at 0x1c48-0x1c4f, BIOS settings: hdc:DMA, hdd:pio
>>hda: HITACHI_DK23CA-20, ATA DISK drive
>>hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
>>
>>That's the last line I see from a 2.5.10 kernel booting up. 2.5.9 does go
>>farther:
> 
> 
> I have a similar problem on the VirtuHammer simulator. On trying to access
> the virtual disk using PIO mode the simular breaks with an error
> in a rep ; outsb loop complaining about "writing data while in data in phase".
> I guess your problem could be the same, as the DVD is likely accessed
> using PIO. 2.5.10 fails, 2.5.9 works.


please apply IDE 41. There are known errors there.

