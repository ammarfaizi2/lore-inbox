Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289741AbSAJWUj>; Thu, 10 Jan 2002 17:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289740AbSAJWUY>; Thu, 10 Jan 2002 17:20:24 -0500
Received: from e24.nc.us.ibm.com ([32.97.136.230]:63398 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289744AbSAJWUS>; Thu, 10 Jan 2002 17:20:18 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201102220.g0AMKF503938@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 10 Jan 2002 14:20:15 -0800 (PST)
Cc: pbadari@us.ibm.com (Badari Pulavarty), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <E16OnQ6-0005gz-00@the-village.bc.nu> from "Alan Cox" at Jan 10, 2002 09:11:34 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Something like sd_attach() could get this info from template and
> > set a flag in blk_dev. (or in a gloal array).
> 
> I didnt think blk_dev was per minor ?
> 

hmm.. I see where you are going.  I guess I need to have of a pointer
to arrary of MAX_MINOR. But I can use similar technique as "blksize_size"
arrary. 

Otherwise, I can have gloabl arrary similar to "blksize_size".

Thanks,
Badari
