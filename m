Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSEQDEZ>; Thu, 16 May 2002 23:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315378AbSEQDEY>; Thu, 16 May 2002 23:04:24 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:14341 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315375AbSEQDEY>; Thu, 16 May 2002 23:04:24 -0400
Date: Fri, 17 May 2002 05:04:07 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: joergprante@gmx.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19pre8][RFC] remove-NFS-close-to-open from VFS (was Re: [PATCHSET] 2.4.19-pre8-jp12)
Message-ID: <20020517030407.GA4595@louise.pinerecords.com>
In-Reply-To: <200205162142.AWF00051@netmail.netcologne.de> <E178TUb-0005Bh-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc4-ext3-0.0.7a SMP (up 20:37)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is it possible to leave the VFS layer untouched? Or restrict the dentry 
> > revalidation to NFS and let other remote file systems coexist, i.e. without 
> > revalidation calls? 
> 
> Really the other file systems want fixing - that revalidation is a real bug
> fix and the situation could occur for other network file systems too

I was able to reproduce the bug on a reiserfs root on one of my machines today.

T.
