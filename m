Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSEAR5O>; Wed, 1 May 2002 13:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313760AbSEAR5N>; Wed, 1 May 2002 13:57:13 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:22333 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S313743AbSEAR5M>; Wed, 1 May 2002 13:57:12 -0400
Date: Wed, 1 May 2002 19:56:20 +0200
From: Stephane Chauveau <s.chauveau@chello.nl>
To: linux-kernel@vger.kernel.org
Cc: lk@bigsexymo.com
Subject: Re: EXT3 - freeze ups during disk writes
Message-ID: <20020501195620.A5077@simak.arnhem.chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a reply for the thread started by Erik Elmore on Dec 02 2001.

I experienced the same problem today after switching from a customized
kernel (2.4.17) to the official debian kernel (2.4.18). During intensive
ext3 disk writes, the PC freezes each 4 or 5 seconds.

The generic debian kernel does not enable dma by default. I solved the
pb with hdparm. 
S.





