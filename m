Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSE3LIw>; Thu, 30 May 2002 07:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSE3LIv>; Thu, 30 May 2002 07:08:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23537 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316579AbSE3LIu>; Thu, 30 May 2002 07:08:50 -0400
Subject: Re: PCI - docos/where to start?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Creswell <dan@dcrdev.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CF5E6E8.40509@dcrdev.demon.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 May 2002 13:12:30 +0100
Message-Id: <1022760750.4124.349.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-30 at 09:46, Dan Creswell wrote:
> I've got a new laptop here with a chipset that isn't currently properly 
> identified/configured by linux (it's Intel 845MP based - specifically, 
> Linux doesn't recognise the ISA bridge component which controls sound 
> card etc.).
> 
> I'd like to fix this up myself so I was wondering if someone could give 
> me some pointers to bits of kernel code/documentation I should be 
> looking at before undertaking this work?

I pushed the ICH4 (845) audio patch to Marcelo yesterday. It's in the
-ac tree. Basically it just adds PCI identifiers

