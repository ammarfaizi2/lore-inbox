Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314652AbSEPUFN>; Thu, 16 May 2002 16:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314653AbSEPUFM>; Thu, 16 May 2002 16:05:12 -0400
Received: from pc132.utati.net ([216.143.22.132]:40097 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S314652AbSEPUFM>; Thu, 16 May 2002 16:05:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.21-rc4
Date: Thu, 16 May 2002 10:06:45 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200205152039.g4FKdcn08311@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020516203131.4813E472@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 May 2002 04:39 pm, Alan Cox wrote:
> Unless something bad turns up this will be the final 2.2.21.
>
> 2.2.21rc4
> o	SiS900 updates					(Mufasa Yang)

I wonder if this (or another known patch) fixes an SiS900 problem I've been 
experiencing on 2.4.18.  When you unplug and plug back in the cat 5 cable 
(forcing it to redetect the link), it starts dropping packets like mad until 
the next reboot.  Ping shows this up nicely...

I reported this problem a week or two back...

http://lists.insecure.org/linux-kernel/2002/May/0629.html

...but haven't really followed up yet.  (It's a "don't do that then" at the 
moment.)  I should probably go ask Donald Becker.  (I should also try 
compiling as a module and doing insmod/rmmod and see if that fixes it, but 
that's not really a fix, it's another workaround...)

Rob
