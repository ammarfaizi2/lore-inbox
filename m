Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278578AbRJSS0n>; Fri, 19 Oct 2001 14:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278579AbRJSS0e>; Fri, 19 Oct 2001 14:26:34 -0400
Received: from freeside.toyota.com ([63.87.74.7]:19985 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S278578AbRJSS0U>;
	Fri, 19 Oct 2001 14:26:20 -0400
Message-ID: <3BD07066.182DA478@lexus.com>
Date: Fri, 19 Oct 2001 11:26:46 -0700
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerhard Mack <gmack@innerfire.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.12 breaks fdisk
In-Reply-To: <Pine.LNX.4.10.10110191109350.10415-100000@innerfire.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen this on some systems -

IFAIK it is a BIOS problem, not a
kernel problem -

cu

jjs

Gerhard Mack wrote:

> Somone break something?  I can only seem to access new partitions after a
> reboot.
>
> Calling ioctl() to re-read partition table.
> rotyla:~# mkreiserfs /dev/hda4
>
> <-------------mkreiserfs, 2001------------->
> reiserfsprogs 3.x.0j
>
> count_blocks: open failed (No such device or address)
>
> rotyla:~# mke2fs /dev/hda4
> mke2fs 1.25 (20-Sep-2001)
> mke2fs: No such device or address while trying to determine filesystem
> size
>
> --
> Gerhard Mack
>
> gmack@innerfire.net
>
> <>< As a computer I find your faith in technology amusing.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

