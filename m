Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278514AbRKHMb2>; Thu, 8 Nov 2001 07:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278041AbRKHMbT>; Thu, 8 Nov 2001 07:31:19 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:26126 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277317AbRKHMbF>;
	Thu, 8 Nov 2001 07:31:05 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "BALBIR SINGH" <balbir.singh@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspected error in make dep 
In-Reply-To: Your message of "Thu, 08 Nov 2001 15:38:27 +0530."
             <3BEA599B.6080606@wipro.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 08 Nov 2001 23:30:53 +1100
Message-ID: <20204.1005222653@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Nov 2001 15:38:27 +0530, 
"BALBIR SINGH" <balbir.singh@wipro.com> wrote:
>Pentium III, 128MB, Linux 2.4.13 while running make dep on 2.4.14
>
>sa1100fb.c:164:27: linux/cpufreq.h: No such file or directory
>I was wondering why this file is used in make dep. Did I miss something or
>should I wait for kbuild in 2.5?

make dep is fundamentally flawed, ignore all "file not found" messages.
Roll on kbuild 2.5, no more "make dep"!.

