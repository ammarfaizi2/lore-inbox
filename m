Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132575AbRDEIHI>; Thu, 5 Apr 2001 04:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132573AbRDEIG7>; Thu, 5 Apr 2001 04:06:59 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:19857 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S132572AbRDEIGx>; Thu, 5 Apr 2001 04:06:53 -0400
Message-ID: <3ACC2642.45CFD374@oracle.com>
Date: Thu, 05 Apr 2001 10:01:06 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ion Badulescu <ionut@moisil.cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.3 crashed my hard disk
In-Reply-To: <E14kybO-0003Bk-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the null message, fingers slipped :(

Alan Cox wrote:
> 
> > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> > is about the most ominous message one can receive from the IDE driver:
> >
> > 1. it's not in English, so it doesn't tell you jack
> 
> It tells you the chipset doesnt support an IDE dma timeout handling function
> (ie all it can do is reset and retry)
> 
> > 2. it's usually a sign of "mkfs + reinstall needed"
> 
> Not in my experience. Its just a drive throwing a fit.
> 

Indeed, I hit this regularly on my Samsung CD-ROM on my Dell laptop.

Everything locks up for a few seconds, then the ATAPI reset kicks
 in and all works again. The CD drive is a piece of crud.

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19/2.4.3p8 glibc-2.2 gcc-2.96-69 binutils-2.11.90.0.1
Oracle: Oracle8i 8.1.7.0.1 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
