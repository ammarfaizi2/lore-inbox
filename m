Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317136AbSEXPIA>; Fri, 24 May 2002 11:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317137AbSEXPH7>; Fri, 24 May 2002 11:07:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22796 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317136AbSEXPH5>; Fri, 24 May 2002 11:07:57 -0400
Subject: Re: It hurts when I shoot myself in the foot
To: adilger@clusterfs.com (Andreas Dilger)
Date: Fri, 24 May 2002 16:28:13 +0100 (BST)
Cc: chris@directcommunications.net (Chris), linux-kernel@vger.kernel.org
In-Reply-To: <20020523054219.GL458@turbolinux.com> from "Andreas Dilger" at May 22, 2002 11:42:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BGzF-0006b3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That was what I was trying to say: same FSB speed * different multipliers
> = different CPU MHZ, like what the original poster is asking about.
> I don't think it is possible to configure a motherboard to have different
> FSB speeds for two processors.

The Intel pentium II/III FSB at least can't handle this with normal chipsets. 
You can run same FSB different multipliers but this not officially supported.
I have code to detect the multiplier of each CPU but never got around to
making the kernel detect this and turn off TSC usage so you need to boot
with "notsc" in such a case
