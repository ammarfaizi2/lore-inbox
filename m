Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315820AbSEEC13>; Sat, 4 May 2002 22:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315819AbSEEC12>; Sat, 4 May 2002 22:27:28 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:22532 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315822AbSEEC11>;
	Sat, 4 May 2002 22:27:27 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 release 2.4 
In-Reply-To: Your message of "Sat, 04 May 2002 09:19:51 MST."
             <Pine.LNX.4.33.0205040918450.22716-100000@osdlab.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 May 2002 12:27:17 +1000
Message-ID: <2334.1020565637@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2002 09:19:51 -0700 (PDT), 
<rddunlap@osdl.org> wrote:
>On Sat, 4 May 2002, tomas szepe wrote:
>
>| Hmm, I don't think this analogy will do -- working with aliases involving
>| fileutils as root is a way straight to hell, and hardly anyone ever walks
>| it. With kbuild-2.5, however, I have to set $KBUILD_OBJTREE every time
>| I want to build a kernel with objects out of the source dir -- and hey,
>| is there a single person on this list who's never made a typo on the
>| command line?
>|
>| I don't know how to properly emphasize that this *is* asking for problems,
>| but still I'd be surprised if I were the only one scared by files not
>| connected to the build getting erased on make mrproper. Hello, anyone? :)
>
>Too much policy here?
>
>| Would it be complicated to only kill the files the build knows it had
>| created?
>
>That's what I would expect.

OK, it is now officially classed as an over optimization.  I will
change clean/mrproper in core-12 to only delete known files.

