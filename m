Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289317AbSBJHNe>; Sun, 10 Feb 2002 02:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289326AbSBJHNZ>; Sun, 10 Feb 2002 02:13:25 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:27149
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S289317AbSBJHNQ>; Sun, 10 Feb 2002 02:13:16 -0500
Message-Id: <5.1.0.14.2.20020210020753.022936a0@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 10 Feb 2002 02:08:45 -0500
To: Andrew Morton <akpm@zip.com.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>
From: Stevie O <stevie@qrpff.net>
Subject: Re: [PATCH] BUG preserve registers
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C66181C.95DF04E3@zip.com.au>
In-Reply-To: <Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com>
 <Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com>
 <m1k7tl6ek2.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:50 PM 2/9/2002 -0800, Andrew Morton wrote:
> > .linkonce discard
> > 1: .asciz __FILE__
> > .previous
> >
> > Which will put each filename string in it's own section and let the
> > linker merge the duplicates.
>
>That would work.  When it didn't I r'ed tfm:
>
>         http://www.gnu.org/manual/gas-2.9.1/html_node/as_102.html
>
>         "This directive is only supported by a few object file formats;
>         as of this writing, the only object file format which supports
>         it is the Portable Executable format used on Windows NT."


So, all we need to do is port Linux to run under NT? ;)


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

