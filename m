Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267402AbRGLBZr>; Wed, 11 Jul 2001 21:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbRGLBZi>; Wed, 11 Jul 2001 21:25:38 -0400
Received: from woodyjr.wcnet.org ([63.174.200.2]:40365 "EHLO woodyjr.wcnet.org")
	by vger.kernel.org with ESMTP id <S267402AbRGLBZZ>;
	Wed, 11 Jul 2001 21:25:25 -0400
Message-ID: <001501c10a71$68c66820$0200000a@laptop>
From: "C. Slater" <cslater@wcnet.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C92A@mail0.myrio.com>
Subject: Re: Switching Kernels without Rebooting?
Date: Wed, 11 Jul 2001 21:24:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone else like to point out some other task somewhat related 
and have me do it? :-)

> > Before you even try switching kernels, first implement a process
> > checkpoint/restart. The process must be resumed after a boot
> > using the same
> > kernel, with all I/O resumed. Now get it accepted into the kernel.
> 
> Hear, hear!  That would be a useful feature, maybe not network servers, 
> but for pure number crunching apps it would save people having to write 
> all the state saving and recovery that is needed now for long term 
> computations.

Get a computer with hibernation support. That's just about what it is.

> 
> For bonus points, make it work for clusters to synchronously save and
> restore state for the apps running on all the nodes at once...

Bash script.

> 
> Torrey

