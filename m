Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSEXP5z>; Fri, 24 May 2002 11:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317183AbSEXP5t>; Fri, 24 May 2002 11:57:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7693 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317176AbSEXPzh>; Fri, 24 May 2002 11:55:37 -0400
Subject: Re: [BUG] 2.4 VM sucks. Again
To: Martin.Bligh@us.ibm.com (Martin J. Bligh)
Date: Fri, 24 May 2002 17:14:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk), linux-kernel@vger.kernel.org
In-Reply-To: <421830000.1022255618@flay> from "Martin J. Bligh" at May 24, 2002 08:53:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BHiQ-0006mJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What sort of setup. I can't duplicate the problem here ?
> 
> I'm not sure exactly what Roy was doing, but we were taking a machine
> with 16Gb of RAM, and reading files into the page cache - I think we built up
> 8 million buffer_heads according to slabinfo ... on a P4 they're 128 bytes each,
> on a P3 96 bytes.

The buffer heads one would make sense. I only test on realistic sized systems. 
Once you pass 4Gb there are so many problems its not worth using x86 in the
long run

