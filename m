Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbREVWrb>; Tue, 22 May 2001 18:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbREVWrV>; Tue, 22 May 2001 18:47:21 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:44813 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262876AbREVWrK>; Tue, 22 May 2001 18:47:10 -0400
Date: Wed, 23 May 2001 00:47:07 +0200 (CEST)
From: Tomas Telensky <ttel5535@ss1000.ms.mff.cuni.cz>
Reply-To: ttel5535@artax.karlin.mff.cuni.cz
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: linux-kernel@vger.kernel.org,
        "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <9ebbg2$m62$1@tazenda.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105230032440.31122-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 May 2001, H. Peter Anvin wrote:

> Followup to:  <3B090C81.53F163C3@TeraPort.de>
> By author:    "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
> In newsgroup: linux.dev.kernel
> >
> > Hi,
> > 
> >  while trying to enhance a small hardware inventory script, I found that
> > cpuinfo is missing the details of L1, L2 and L3 size, although they may
> > be available at boot time. One could of cource grep them from "dmesg"
> > output, but that may scroll away on long lived systems.
> > 
> 
> Any particular reason this needs to be done in the kernel, as opposed

It is already done in kernel, because it's displaying :)
So, once evaluated, why not to give it to /proc/cpuinfo. I think it makes
sense and gives it things in order.

	Tomas

> to having your script read /dev/cpu/*/cpuid?


