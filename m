Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314657AbSEBRQv>; Thu, 2 May 2002 13:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314658AbSEBRQu>; Thu, 2 May 2002 13:16:50 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:23531 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314657AbSEBRQu>; Thu, 2 May 2002 13:16:50 -0400
Date: Thu, 2 May 2002 18:56:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nick Ciesinski <ciesinskna26@uww.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: i860 Chipset and Hyper-Threading Processors
In-Reply-To: <E173K81-0004NP-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0205021850340.12156-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, Alan Cox wrote:

> > ENABLING IO-APIC IRQs
> > BIOS bug, IO-APIC#0 ID 2 is already used!...
> > ... fixing up to 4. (tell your hw vendor)
> > ...changing IO-APIC physical APIC ID to 4 ... ok.
> 
> The BIOS booted up with two devices having the same device ID. Thats a bit
> naughty but I don't think its technically a violation of the MP 1.4 spec
> merely very dumb 8). Linux renumbered it for you

Just a few questions, the logical CPUs don't go through the same boot up 
sequence (BIST etc) too do they? So they don't really exist when the 
physical CPUs are doing power on setup. If thats the case, then do the 
physical CPUs fill in the MP table info for their siblings?

Thanks,
	Zwane "it-doesnt-take-much-to-confuse-me" Mwaikambo

-- 
http://function.linuxpower.ca
		

