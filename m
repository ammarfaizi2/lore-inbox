Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281504AbRK0Q7d>; Tue, 27 Nov 2001 11:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281541AbRK0Q7Y>; Tue, 27 Nov 2001 11:59:24 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:25869 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S281504AbRK0Q7S>; Tue, 27 Nov 2001 11:59:18 -0500
Subject: Re: mounting NTFS
From: Richard Russon <ntfs@flatcap.org>
To: linuxlist@visto.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BE042D00016CB26@iso1.vistocorporation.com> (added by
	administrator@vistocorporation.com)
In-Reply-To: <3BE042D00016CB26@iso1.vistocorporation.com> (added by
	administrator@vistocorporation.com)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 27 Nov 2001 16:59:15 +0000
Message-Id: <1006880355.5585.26.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohit,

> I have a kernel version of 2.4.7

Ah.  Is that RedHat's 2.4.7?

> When I try ,
> 
>  mount -t ntfs /dev/hda1 /mnt/msdos
> 
> I get a message ntfs not supported, where as the manual on mount
> indicates that ntfs is supported / mountable.

As Francois says, check /proc/filesystems.  If you don't find ntfs
there, you'll have to build a new kernel (not as scary as it sounds).

  http://www.linuxdoc.org/HOWTO/Kernel-HOWTO.html

covers ALL the details.  If you have a RedHat system, then install the
kernel source and you'll find a .config that matches your system.  You
just need to select NTFS support.

If you have any more questions or problems please go to our NTFS help
forum:

  http://sourceforge.net/forum/forum.php?forum_id=44085

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org



