Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129920AbRBCDDg>; Fri, 2 Feb 2001 22:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130369AbRBCDD0>; Fri, 2 Feb 2001 22:03:26 -0500
Received: from snoopy.apana.org.au ([202.12.87.129]:59400 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S129920AbRBCDDX>; Fri, 2 Feb 2001 22:03:23 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels
In-Reply-To: <20010203004926.M160@pervalidus.dyndns.org>
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 03 Feb 2001 14:03:09 +1100
In-Reply-To: 0@pervalidus.net's message of "3 Feb 01 02:49:26 GMT"
Message-ID: <847l38lb82.fsf@snoopy.apana.org.au>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Frédéric" == Frédéric L W Meunier <0@pervalidus.net> writes:

    Frédéric> Keith Owens wrote:
    >> Rule 2. Any glibc that has a symlink from
    >> /usr/include/{linux,asm} to /usr/src/linux/include/{linux,asm}
    >> is wrong.

    Frédéric> Such symlinks are created by the user.

    >> Relying on /usr/include/{linux,asm} always pointing at the
    >> current kernel source is broken as designed.

    Frédéric> From glibc 2.2.1 FAQ:

    Frédéric> 2.17.  I have /usr/include/net and /usr/include/scsi as
    Frédéric> symlinks into my Linux source tree.  Is that wrong?

    Frédéric> {PB} This was necessary for libc5, but is not correct
    Frédéric> when using glibc. Including the kernel header files
    Frédéric> directly in user programs usually does not work (see
    Frédéric> question 3.5). glibc provides its own <net/*> and
    Frédéric> <scsi/*> header files to replace them, and you may have
    Frédéric> to remove any symlink that you have in place before you
    Frédéric> install glibc. However, /usr/include/asm and
    Frédéric> /usr/include/linux should remain as they were.

    Frédéric> Keith, are you saying that glibc is wrong?

You both seem to be saying the same thing: that symlinks for
/usr/include/{linux,asm} are wrong.

Why try to argue when you agree?

(Debian does this right; last I heard Red-Hat didn't)
-- 
Brian May <bam@snoopy.apana.org.au>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
