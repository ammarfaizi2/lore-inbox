Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSHATyX>; Thu, 1 Aug 2002 15:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316953AbSHATyX>; Thu, 1 Aug 2002 15:54:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9344 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316951AbSHATyW>; Thu, 1 Aug 2002 15:54:22 -0400
Date: Thu, 1 Aug 2002 15:58:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gary Lawrence Murphy <garym@canada.com>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       garym@teledyn.com
Subject: Re: Kernel compiled from source won't read /parts/ of a CD?
In-Reply-To: <m2bs8mtlit.fsf@maya.dyndns.org>
Message-ID: <Pine.LNX.3.95.1020801154900.873A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Aug 2002, Gary Lawrence Murphy wrote:

> 
> This is one of the strangest situations I have ever seen: my
> re-compiled Linux 2.4.18 kernel now /refuses/ to read /only/ the
> "/Mandrake" directory branch of all three of the Mandrake distribution
> CDs.  It /has/ to be some kernel option, but I can't figure which one;
> any advice or debugging hints at all are greatly appreciated.

I had some problem like this. I don't know what caused it
because it was 'fixed' by a re-boot. I think it was that
the kernel 'thought' the block-size was wrong for the CD.

Anyway, the next time it happend, I copied the entire
contents of a CD to a file (ising 'cp'). I then mounted
the file through the loop device. I figured it might be
quicker than re-booting (it wasn't). It worked anyway.

The next time it happens, I will try to mount the CD
through the loop device. Anyway, you can try that now.

Maybe it will help you read it.

mount -t iso9660 -o loop /dev/cdrom /mnt

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

