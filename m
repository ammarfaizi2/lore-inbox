Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSLQS4k>; Tue, 17 Dec 2002 13:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSLQS4k>; Tue, 17 Dec 2002 13:56:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7908
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265361AbSLQS4j>; Tue, 17 Dec 2002 13:56:39 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
In-Reply-To: <3DFF717C.90006@redhat.com>
References: <Pine.LNX.4.44.0212170858510.2702-100000@home.transmeta.com>
	<3DFF6501.3080106@redhat.com>
	<1040153030.20804.8.camel@irongate.swansea.linux.org.uk> 
	<3DFF717C.90006@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 19:44:33 +0000
Message-Id: <1040154273.20804.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 18:48, Ulrich Drepper wrote:
> Alan Cox wrote:
> 
> > Is there any reason you can't just keep the linker out of the entire
> > mess by generating
> > 
> > 	.byte whatever
> > 	.dword 0xFFFF0000
> > 
> > instead of call ?
> 
> There is no such instruction.  Unless you know about some secret
> undocumented opcode...

No I'd forgotten how broken x86 was

