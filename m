Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262361AbSI2BLr>; Sat, 28 Sep 2002 21:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262362AbSI2BLr>; Sat, 28 Sep 2002 21:11:47 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:25873 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262361AbSI2BLq>;
	Sat, 28 Sep 2002 21:11:46 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Does kernel use system stdarg.h? 
In-reply-to: Your message of "Sat, 28 Sep 2002 18:26:43 +0100."
             <20020928182643.A13064@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Sep 2002 11:16:55 +1000
Message-ID: <13406.1033262215@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2002 18:26:43 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>This seems to leave us with no official guaranteed way to get at the
>compiler specific includes, which is Bad News(tm).  We obviously can't
>use "-I/usr/lib/gcc-lib/`gcc -dumpmachine`/`gcc -dumpversion`/" and
>we've already had problems with the 2.4 "gcc -print-search-dirs"
>version.

LANG=C gcc -print-search-dirs | sed ...

