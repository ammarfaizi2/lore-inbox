Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313038AbSEVMYj>; Wed, 22 May 2002 08:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSEVMYj>; Wed, 22 May 2002 08:24:39 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:11026 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313038AbSEVMYi>; Wed, 22 May 2002 08:24:38 -0400
Date: Wed, 22 May 2002 14:24:28 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Joris Braakman <jorisb@nl.euro.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 SPARC SMP oops
Message-ID: <20020522122428.GB26844@louise.pinerecords.com>
In-Reply-To: <20020522131202.B6096@lama.euronet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc4-ext3-0.0.7a SMP (up 6 days, 6:02)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following oops looks a lot like Tomas Szepe oops, so I copied the
> subject.
> 
> I could still login with ssh, su to root and issue a reboot, which
> didn't work completely, but after a halt command I got the bootprompt 
> on the console and issued a boot. Other commands as ps or top didn't
> work.  ls did work. It happened under heavy load. The machine was running 
> for more than one day with this load.
> 
> It is a sparc 5, single processor, 128MB.

I assume this is indeed the well-known SRMMU bug. It's very easy to
reproduce actually, just stress the machine so that the load reaches
20+. For a temporary and imperfect solution, look up the relevant
thread on the aurora sparc mailing list.

Someone is supposed to have been working on a fix for some time now.

T.
