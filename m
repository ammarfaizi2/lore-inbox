Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316367AbSEVRdM>; Wed, 22 May 2002 13:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316388AbSEVRdL>; Wed, 22 May 2002 13:33:11 -0400
Received: from 200-180-165-040-paemt7002.dsl.telebrasilia.net.br ([200.180.165.40]:52334
	"EHLO uvsqua000.quatro.com.br") by vger.kernel.org with ESMTP
	id <S316367AbSEVRdI>; Wed, 22 May 2002 13:33:08 -0400
Message-ID: <00f801c201b6$8d77a7a0$9c0016ac@quatro>
From: "Fernando [Quatro]" <fernando@quatro.com.br>
To: "Eric Weigle" <ehw@lanl.gov>
Cc: "Linux kernel mailing list \(lkml\)" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020522165320.GC18059@lanl.gov>
Subject: Re: Safety of -j N when building kernels?
Date: Wed, 22 May 2002 14:31:35 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, stupid question of the moment-
> 
> I always read about the kernel compilation benchmarks people run on the
> ultra-snazzy new machines, but do people actually run the kernels thus
> generated?
> 
> I have visions of a process being backgrounded to generate some files, and
> not completing before the one of the old files gets linked into the kernel
> (because not all files were listed as dependencies, for example).
> 
> So are the kernel's current Makefiles really SMP safe -- can one really
> run multiple jobs when building Linux kernels? Any horror stories, or am
> I just paranoid?

I think it's safe... I ran a `make -j` once (dual pIII 933MHz, 1Gb RAM).
The load average went to 200+!  In the end, the kernel was fine and booted
all right... I don't do that anymore because it takes longer building with a sane number
in 'make -j N'...




--------------------------------------------------
Fernando Korndorfer - fernando@quatro.com.br
Quatro Informatica Ltda.
Novo Hamburgo - RS/Brasil
--------------------------------------------------

