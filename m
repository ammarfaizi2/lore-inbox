Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316189AbSEKBjl>; Fri, 10 May 2002 21:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316190AbSEKBjk>; Fri, 10 May 2002 21:39:40 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:24070 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316189AbSEKBjj>;
	Fri, 10 May 2002 21:39:39 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak 
In-Reply-To: Your message of "Sat, 11 May 2002 11:34:07 +1000."
             <2764.1021080847@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 11:39:30 +1000
Message-ID: <2888.1021081170@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002 11:34:07 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>The variable length i386 instructions are a problem, finding a decent
>start point is tricky.  ksymoops handles up to 64 bytes of code so
>dumping EIP-56:EIP+8 would increase the chance of the disassembler
>syncing to the correct instructions.

Duh, fencepost.  EIP-56:EIP+7, of course.

