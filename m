Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281709AbRKUK4V>; Wed, 21 Nov 2001 05:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281708AbRKUK4M>; Wed, 21 Nov 2001 05:56:12 -0500
Received: from [194.65.152.209] ([194.65.152.209]:15791 "EHLO
	criticalsoftware.com") by vger.kernel.org with ESMTP
	id <S281706AbRKUK4E>; Wed, 21 Nov 2001 05:56:04 -0500
Message-Id: <200111211055.fALAtP287652@criticalsoftware.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Lu=EDs=20Henriques?= 
	<lhenriques@criticalsoftware.com>
To: "Tyler BIRD" <BIRDTY@uvsc.edu>, <adilger@turbolabs.com>
Subject: Re: copy to suer space
Date: Wed, 21 Nov 2001 10:49:43 +0000
X-Mailer: KMail [version 1.3.1]
Cc: <aia21@cam.ac.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <sbfa4d3a.051@MAIL-SMTP.uvsc.edu>
In-Reply-To: <sbfa4d3a.051@MAIL-SMTP.uvsc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 November 2001 07:31 pm, Tyler BIRD wrote:
> What is the other "specifc event that occurs" you could write a spinlock
> and the other thread that causes the event could release that lock
> Of course interrups should be enabled when some thing like this should
> happen Is this other event a interrupt?

The specific event is a breakpoint interrupt: when a specific memory address 
is used (for opcode fetch/read/write) in the addressing space of a process, 
then an exception is raised and a handler for this exception will be called - 
this is my module.

>
>
> There are various ways I'll have to look up when I get home.
> you could alter the cs if you change the vma properties especially the
> permissions properties and you can do this I just don't have the details
> now.
>
> the cs is protected by default
> Tyler
>

-- 
Luís Henriques
