Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312805AbSDBGSF>; Tue, 2 Apr 2002 01:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312806AbSDBGR4>; Tue, 2 Apr 2002 01:17:56 -0500
Received: from rj.sgi.com ([204.94.215.100]:21405 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S312805AbSDBGRu>;
	Tue, 2 Apr 2002 01:17:50 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Stevie O <stevie@qrpff.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 oops & ksymoops 2.4.5 & libbfd.a 
In-Reply-To: Your message of "Tue, 02 Apr 2002 00:47:41 EST."
             <5.1.0.14.2.20020402004442.00b05cd8@whisper.qrpff.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Apr 2002 16:17:40 +1000
Message-ID: <26460.1017728260@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Apr 2002 00:47:41 -0500, 
Stevie O <stevie@qrpff.net> wrote:
>So I downloaded it, tried to compile, and got a bunch of 'undefined reference's from merge.o in libbfd.a.

ksymoops works for me using binutils version 2.10.91 (with BFD
2.10.91.0.2).  I have no idea why ksymoops fails with other versions of
libbfd, especially with unresolved references.  AFAICT this is a bfd
problem.  Ask the binutils people and, if you get an answer, let us
know what it was.

