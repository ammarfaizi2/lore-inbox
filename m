Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVHLIA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVHLIA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 04:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVHLIA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 04:00:28 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:58191 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750780AbVHLIA2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 04:00:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hFcKXESmckSzInmNFD3A5VSlrY2/mSOI2sa8pKtQnV4wF9+j+/OuJgLhXajuFOFVahJBFOiSAar1x5ZgFCvKLAdRVXENUtp/US1GXK7o2Utg5yX8l7vdBlbZgKja874Tk83EUrXrMU1X+P0x2/A2xPeNoN6DzLHV9mnt1o8WOgg=
Message-ID: <7f45d93905081201001a51d51b@mail.gmail.com>
Date: Fri, 12 Aug 2005 01:00:27 -0700
From: Shaun Jackman <sjackman@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <42FC0DD4.9060905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d939050809163136a234a@mail.gmail.com>
	 <42FC0DD4.9060905@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/8/11, Tejun Heo <htejun@gmail.com>:
> Shaun Jackman wrote:
> > I added a PCI SATA controller to my computer. Immediately after grub
> > loads the kernel there is a consistent ten minute delay before the
> > kernel displays its first message. I tested Linux 2.6.8 and 2.6.11
> > both from Debian, and 2.6.11 from Knoppix, all of which experience the
> > same delay.
>
>   * What do you mean by the `first' message?  ie. What's the first line
> you read?
>   * Is it really ten minutes?

Hello, Tejun. Thanks for the reply.

The message displayed by the bootloader, grub, is...
root (hd2,2)
	Filesystem type is ext2fs, partition type 0x83
kernel /boot/vmlinuz-2.6.11-1-k7 root=/dev/md0 ro nodma
	[Linux-bzImage, setup=0x1600, size=0x122a667]
initrd /boot/initrd.img-2.6.11-1-1-k7
	[Linux-initrd @ 0x1fb29000, 0x4c6000 bytes]
boot

At this point there is a nine minute, fifteen second delay. As soon as
the kernel starts printing messages it goes by quite fast, so I can't
be certain what it's printing, but the first message according to
dmesg is...
Linux version 2.6.11-1-k7 (dannf@firetheft) (gcc version 3.3.6 (Debian 1:3.3.6-6
)) #1 Mon Jun 20 21:26:23 MDT 2005
BIOS-provided physical RAM map:
...

Cheers,
Shaun
