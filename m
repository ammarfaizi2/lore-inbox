Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSELLvU>; Sun, 12 May 2002 07:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSELLvT>; Sun, 12 May 2002 07:51:19 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:59916 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312962AbSELLvS>;
	Sun, 12 May 2002 07:51:18 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Hugh <hugh@nospam.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre8-ac2 kbuild 2.4 tmp_include_depends 
In-Reply-To: Your message of "Sun, 12 May 2002 20:31:17 +0900."
             <3CDE5285.8030205@nospam.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 May 2002 21:50:26 +1000
Message-ID: <22738.1021204226@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 20:31:17 +0900, 
Hugh <hugh@nospam.com> wrote:
>I am definitely a newbie as far as patch file handling is concerned.
>
>I took the patch portion starting from
>
>diff -ur 2.4.19-pre8-ac2/Makefile 2.4.19-pre8-ac2-test/Makefile
>
>and ending with
>
>MODVERFILE := $(TOPDIR)/include/linux/modversions.h
>
>which is the last line,
>and made it a file named Keith.patch.  Then, I went to /usr/src/linux
>and issued
>
>patch -p1 < Keith.patch
>
>Well.... That did not work.  WHat did I do wrong?

Download message in raw format, save as text not source and patch
direct from the downloaded file, no need to edit it.  If patches are
too difficult, just use unpatched 2.4.19-pre8-ac2 with 'make clean dep'
instead of 'make dep clean'.

