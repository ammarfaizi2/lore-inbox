Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261336AbRFNHhx>; Thu, 14 Jun 2001 03:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbRFNHhn>; Thu, 14 Jun 2001 03:37:43 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:20667 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S261336AbRFNHh2>; Thu, 14 Jun 2001 03:37:28 -0400
Message-ID: <3B2869F9.D0AE17CB@idcomm.com>
Date: Thu, 14 Jun 2001 01:38:33 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: bzDisk compression Q; boot debug Q
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678F59@mail-in.comverse-in.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Khachaturov, Vassilii" wrote:
> 
> > Question 2, apparently ramdisk uses gzip compression; the name of the
> > kernel from make bzImage seems to maybe refer to bzip2 compression. Is
> > the kernel image using gzip or bzip2 compression for bzImage? Would
> bzImage stands for "big zImage" - this is a format invented for kernels that
> don't fit into zImage. bzip2 has nothing to do with it :)

Compression is one of those areas someone is always claiming to own a
part of, so it is a pain to deal with. But I still curious, how
effective is the compression that "big zImage" uses, compared to
something like bzip2? If the algorithm is the same as what gzip uses,
I'd imagine that some of my current 1.6 MB boot images could be brought
down to 1.44 MB. But then it would also have to be self-extracting,
which complicates it, so I'm wondering how effective this current
compression is, and if a more bzip2-like system would be beneficial as
kernels get larger?

D. Stimits, stimits@idcomm.com
