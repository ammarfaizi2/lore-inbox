Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287933AbSAUT0O>; Mon, 21 Jan 2002 14:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSAUT0H>; Mon, 21 Jan 2002 14:26:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29457 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287933AbSAUTZh>; Mon, 21 Jan 2002 14:25:37 -0500
Subject: Re: Athlon PSE/AGP Bug
To: reid.hekman@ndsu.nodak.edu (Reid Hekman)
Date: Mon, 21 Jan 2002 19:37:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, alan@lxorg.ukuu.org
In-Reply-To: <1011610422.13864.24.camel@zeus> from "Reid Hekman" at Jan 21, 2002 04:53:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16SkGH-0000Ut-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That errata lists all Athlon Thunderbirds as affected and all Athlon
> Palominos except for stepping A5. 
> 
> Regardless of specific errata listings, will future workarounds be
> enabled based on cpuid or via a test for the bug itself?

That problem shouldnt be hitting Linux x86. I don't know about the
Nvidia module but the base kernel shouldnt hit an invlpg on 4Mb pages
