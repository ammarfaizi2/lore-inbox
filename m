Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130092AbRA3ABz>; Mon, 29 Jan 2001 19:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130982AbRA3ABp>; Mon, 29 Jan 2001 19:01:45 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:63244 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S130092AbRA3ABb>; Mon, 29 Jan 2001 19:01:31 -0500
From: Frank Krauss <fmfkrauss@mindspring.com>
To: linux-kernel@vger.kernel.org
Subject: Loss of Data within the Kernel Source Tree
Date: Mon, 29 Jan 2001 18:57:28 -0500
X-Mailer: KMail [version 0.7.9]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01012919010900.00725@localhost>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had recently an interesting or strange problem occur to me that
I hope someone can explain to me.

I'm running Linux on my Intel P.C.
My Distribution is Caldera OpenLinux 1.3
My Kernel is 2.2.17
I have created at least five Kernels since November, 2000 without any
problems at all.

I recently attempted to upgrade my VIM program to 5.7.

During the make step, I got a lot of errors.  Thanks to Bram Moolenaar's
assistance, he pointed me to the fact that perhaps some files were missing
on my System that were needed by the make step.

I then found out, to my astonishment, that the data within my Linux Source
Tree had somehow been deleted WITHOUT the files themselves being erased.
I have included at the bottom of this report a sample of two of the Directories
where this occurred.

Please note that the Last Modification Time appears to be correct even though
there is NO data in the File.

1.   Has anyone ever seen anything like this before?
2.   Does anyone know what I may have done to cause this problem?
3.   If this is some type of known problem, is there any fix that I could
     put on my System to keep this from happening again?

Any assistance in correcting this strange problem would be greatly appreciated
since this caused me to waste a lot of time thinking it was a VIM problem
rather than it being a System Problem.

Thank you in advance to anyone who could help me with this problem.

Yours truly,

Frank Krauss

-----------------------------------------------------------------------
Sample list of /usr/src/linux/include/linux

-rw-r--r--   1 1007     1007            0 Nov 12 11:00 a.out.h
-rw-r--r--   1 1007     1007            0 Jun  7  2000 ac97_codec.h
-rw-r--r--   1 1007     1007            0 Nov 12 11:01 acct.h
-rw-r--r--   1 1007     1007            0 Jan 24 14:44 adfs_fs.h
-rw-r--r--   1 1007     1007            0 Jan 20  1998 adfs_fs_i.h
-rw-r--r--   1 1007     1007            0 Jan 24 14:44 adfs_fs_sb.h
-rw-r--r--   1 1007     1007            0 Oct 26 11:25 affs_fs.h
-rw-r--r--   1 1007     1007            0 Jan 24 14:44 affs_fs_i.h
-rw-r--r--   1 1007     1007            0 Feb 24  1998 affs_fs_sb.h
-rw-r--r--   1 1007     1007            0 May 14  1997 affs_hardblocks.h
-rw-r--r--   1 1007     1007            0 Jul 30  1998 amifd.h
-rw-r--r--   1 1007     1007            0 Jul 30  1998 amifdreg.h
-rw-r--r--   1 1007     1007            0 Feb 28  1998 amigaffs.h
-rw-r--r--   1 1007     1007            0 May  3  2000 apm_bios.h
-rw-r--r--   1 1007     1007            0 Aug  9  1999 arcdevice.h
-rw-r--r--   1 1007     1007            0 Nov 12 11:09 atalk.h
-rw-r--r--   1 1007     1007            0 Jul 30  1998 atari_rootsec.h
-rw-r--r--   1 1007     1007            0 Nov 12 11:21 auto_fs.h
-rw-r--r--   1 root     root            0 Nov 11 20:58 autoconf.h
-rw-r--r--   1 1007     1007            0 Mar  7  1999 awe_voice.h
-rw-r--r--   1 1007     1007            0 Jul 22  1998 ax25.h
    .
    .
    .
-rw-r--r--   1 1007     1007            0 Oct  5  1998 x25.h
-rw-r--r--   1 1007     1007            0 Aug  9  1999 yam.h
-rw-r--r--   1 1007     1007            0 Nov 25  1997 zftape.h
-rw-r--r--   1 1007     1007            0 Feb 25  1999 zorro.h
-----------------------------------------------------------------------

Sample list of /usr/src/linux/include/asm

-rw-r--r--   1 1007     1007            0 Jun 16  1995 a.out.h
-rw-r--r--   1 1007     1007            0 Nov 12 11:00 atomic.h
-rw-r--r--   1 1007     1007            0 Nov 12 11:00 bitops.h
-rw-r--r--   1 1007     1007            0 Apr 16  1997 boot.h
-rw-r--r--   1 1007     1007            0 Jan 24 14:44 bugs.h
-rw-r--r--   1 1007     1007            0 Jan 24 14:44 byteorder.h
    .
    .
    .
-rw-r--r--   1 1007     1007            0 May 19  1996 unaligned.h
-rw-r--r--   1 1007     1007            0 Jan 20  1999 unistd.h
-rw-r--r--   1 1007     1007            0 Nov 12 11:18 user.h
-rw-r--r--   1 1007     1007            0 Jul 10  1998 vga.h
-rw-r--r--   1 1007     1007            0 Jun 24  1998 vm86.h

End of Data
	        
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
