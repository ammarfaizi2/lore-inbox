Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276552AbRJCRG4>; Wed, 3 Oct 2001 13:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276562AbRJCRGr>; Wed, 3 Oct 2001 13:06:47 -0400
Received: from imo-d06.mx.aol.com ([205.188.157.38]:51118 "EHLO
	imo-d06.mx.aol.com") by vger.kernel.org with ESMTP
	id <S276552AbRJCRGc>; Wed, 3 Oct 2001 13:06:32 -0400
Message-ID: <3BBB4534.774668AC@cs.com>
Date: Wed, 03 Oct 2001 10:04:52 -0700
From: Charles Marslett <cmarslett9@cs.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,zh-TW,ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: partition table read incorrectly
In-Reply-To: <200110031621.QAA03519@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> >> Maybe there is still "0xaa55" on the disk at 0x1fe and the kernel
> >> thinks it is a DOS partition?
> 
> > Note that that is true for *ANY* partition scheme which is bootable,
> > since this is a requirement of the boot firmware interface, rather of
> > any particular partitioning scheme...
> 
> You mean on i386 hardware? With the most common BIOS versions?

I think it applies to almost all boot firmware -- the Atari 68000 hard
disk format used it, all the x86 firmware I am familiar with uses it, and
I think Apple uses it in all it's Mac incarnations.  That's pretty wide
coverage (I know nothing about Sun or other workstation formats).

If the 0xAA55 marker is not present, the standard interpretation is that
the disk is not partitioned, and the disk may still boot, but you may
just be lucky it works if it really is partitioned.

Or have I missed something (I'm not all that familiar with non-x86 hardware
so I could be missing something big -- and I'd like to know that)?

--Charles
