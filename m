Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSC3J6C>; Sat, 30 Mar 2002 04:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312429AbSC3J5w>; Sat, 30 Mar 2002 04:57:52 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:34256 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312426AbSC3J5p>; Sat, 30 Mar 2002 04:57:45 -0500
Date: Sat, 30 Mar 2002 11:46:17 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel hosed or Nvidia modules?
In-Reply-To: <20020330012703.GA16583@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44.0203301144270.18682-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2002, Matthias Andree wrote:

> Is that a genuine kernel bug (2.4.19-pre2-ac3 here) or Yet Another
> Nvidia Driver Bug (would not be the first bug to bite me in their
> driver)? The Nvidia driver is configured to use the kernel AGP rather
> than the Nvidia AGP. (TNT board, FWIW).
> 
> This does not happen frequently. Does anyone have a contact address at
> Nvidia so I can show them as well?
> 
> NVRM: AGPGART: freed 16 pages
> NVRM: AGPGART: backend released
> kernel BUG at page_alloc.c:131!

Using the kernel AGP driver with the TNT and 440BX seems to hose things 
pretty badly in my experience, either use the NvAGP or go sans AGP, 
ideally you don't want the kernel AGP loaded at all.

	Zwane

--
http://function.linuxpower.ca
		

