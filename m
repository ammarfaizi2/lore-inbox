Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSDCWjA>; Wed, 3 Apr 2002 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312431AbSDCWiw>; Wed, 3 Apr 2002 17:38:52 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11657 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312447AbSDCWic>;
	Wed, 3 Apr 2002 17:38:32 -0500
Date: Thu, 4 Apr 2002 00:38:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Message changed in libc
Message-ID: <20020403223811.GA1151@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...so this change makes it way easier to grep...

									Pavel

--- clean.2.5/include/asm-i386/errno.h	Fri Feb  9 20:40:02 2001
+++ linux/include/asm-i386/errno.h	Thu Oct 25 13:24:35 2001
@@ -7,7 +7,7 @@
 #define	EINTR		 4	/* Interrupted system call */
 #define	EIO		 5	/* I/O error */
 #define	ENXIO		 6	/* No such device or address */
-#define	E2BIG		 7	/* Arg list too long */
+#define	E2BIG		 7	/* Argument list too long */
 #define	ENOEXEC		 8	/* Exec format error */
 #define	EBADF		 9	/* Bad file number */
 #define	ECHILD		10	/* No child processes */
									
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
