Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267912AbRGRRbK>; Wed, 18 Jul 2001 13:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbRGRRaw>; Wed, 18 Jul 2001 13:30:52 -0400
Received: from intra.cyclades.com ([209.81.55.6]:525 "HELO intra.cyclades.com")
	by vger.kernel.org with SMTP id <S267864AbRGRRah>;
	Wed, 18 Jul 2001 13:30:37 -0400
Date: Wed, 18 Jul 2001 10:31:50 -0700 (PDT)
From: Ivan Passos <lists@cyclades.com>
To: Nick DeClario <nick@guardiandigital.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: RAMDisk Blues
In-Reply-To: <3B548A9A.2EA1DECA@guardiandigital.com>
Message-ID: <Pine.LNX.4.30.0107181030000.9956-100000@intra.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jul 2001, Nick DeClario wrote:

> Hi,  I know there is this option in the kernel:
>
> Default RAM disk size
> CONFIG_BLK_DEV_RAM_SIZE
>   The default value is 4096. Only change this if you know what are
>   you doing. If you are using IBM S/390, then set this to 8192.
>
> I grabbed that from ~/linux/Documentation/Configure.help.  I have never
> gone about changing this before as the largest RAM disks I have delt
> with were no larger than 3Mb.  But it defaults to 4Mb, so perhaps
> increasing this would solve your problem.

This is set to 131072 (128MB). Just to make sure, I also set it on the
lilo.conf in the append line, with "ramdisk_size=131072". Maybe there is a
limitation in the RAMDisk driver and it doesn't work well with huge
RAMDisk sizes??

Any other hints?!?!

Later,
Ivan

