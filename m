Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271307AbRHXNNV>; Fri, 24 Aug 2001 09:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271371AbRHXNNL>; Fri, 24 Aug 2001 09:13:11 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:41143 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S271307AbRHXNNA>; Fri, 24 Aug 2001 09:13:00 -0400
Date: Fri, 24 Aug 2001 09:28:12 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Alan Cox <laughing@shared-source.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.8-ac10
In-Reply-To: <20010823215443.A17658@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.31.0108240918040.4823-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to test 2.4.8-ac10 to see if the oops on mounting /proc/bus/usb
was fixed.  But I wasn't able to get that far.  I got a panic on trying to
mount the root device (30:01).

I did nothing more than back up my .config file, blow away the Linux
source directory (tried reversing off the patches, but I got lost
somewhere, so I started over), unpack a fresh 2.4.8, patch it up with
-ac10, restore my .config, make oldconfig, dep, install.

I didn't touch my lilo.conf or anything else.

Looking through your changes I didn't notice any mention of changes to the
DAC960 driver (which my root file system resides on).

I had the same thing happen to me at home on a machine with just a scsi
root in a Linus kernel.  I had to make changes to my lilo.conf to get it
to work, but then I had to change it back with the next release.  So I
don't want to jump to any changes just yet.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

