Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314493AbSDRXZa>; Thu, 18 Apr 2002 19:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314495AbSDRXZ3>; Thu, 18 Apr 2002 19:25:29 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:15632
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S314493AbSDRXZ3>; Thu, 18 Apr 2002 19:25:29 -0400
Message-Id: <5.1.0.14.2.20020418191904.028f1290@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 18 Apr 2002 19:19:47 -0400
To: Larry McVoy <lm@bitmover.com>, Kent Borg <kentborg@borg.org>
From: Stevie O <stevie@qrpff.net>
Subject: Re: Versioning File Systems?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020418082025.N2710@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:20 AM 4/18/2002 -0700, Larry McVoy wrote:
>It's certainly a fun space, file system hacking is always fun.  There
>doesn't seem to be a good match between file system operations and
>SCM operations, especially stuff like checkin.  write != checkin.
>But you can handle that with

How about
        fsync(fd) || close(fd) == checkin?



--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

