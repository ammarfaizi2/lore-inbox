Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131833AbRCUXiy>; Wed, 21 Mar 2001 18:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131834AbRCUXio>; Wed, 21 Mar 2001 18:38:44 -0500
Received: from gepetto.dc.luth.se ([130.240.42.40]:7811 "EHLO
	gepetto.dc.luth.se") by vger.kernel.org with ESMTP
	id <S131833AbRCUXii>; Wed, 21 Mar 2001 18:38:38 -0500
Message-ID: <3AB93A75.D18A78EE@student.luth.se>
Date: Thu, 22 Mar 2001 00:34:13 +0100
From: Kirill Kozmin <kozkir-8@student.luth.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VIA686A chipset crash under 2.4.2-ac20
In-Reply-To: <Pine.LNX.4.10.10103161041040.14210-100000@master.linux-ide.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> Okay not to worry, I now have a my hands on a VIA 686B and will look at
> the changes that happened to the VIA686A
>
> Have you run 2.2.18 plus my patches off kernel.org?
>

Ok, now its clear that I have a big troubles with hardware.
I compiled kernel 2.2.18+IDE_patches with support for VIA chipset and still get
errors of type:

kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

before these kernel reports a long string of messages

kernel: hda: Write Cache SUCCESSED Flushing!<6>hda: Write Cache....

Probably it's not a question for this list but what should I do and how can
I determinate broken hardware? (Or configuration? I still hope that it's not a
hardware)


//Kirill

