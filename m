Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137215AbREKTCi>; Fri, 11 May 2001 15:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137213AbREKTC3>; Fri, 11 May 2001 15:02:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47372 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S137215AbREKTAt>; Fri, 11 May 2001 15:00:49 -0400
Subject: Re: Linux 2.4.4-ac7
To: Wayne.Brown@altec.com
Date: Fri, 11 May 2001 19:52:18 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marpet@buy.pl (Marek P=?iso-8859-2?Q?=EAtlicki?=),
        linux-kernel@vger.kernel.org
In-Reply-To: <86256A49.0067820E.00@smtpnotes.altec.com> from "Wayne.Brown@altec.com" at May 11, 2001 01:50:59 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yI1S-0001W2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I always make mrproper after applying your patches, and I still got exactly the
> same problem with nfs that Marek found.  There were no errors or warnings during
> the compile of the objects in the fs/nfs directory or the linking of nfs.o.
> 
Curious : my build has

#define __ver_filemap_fdatasync	f18ce7a1
#define filemap_fdatasync	_set_ver(filemap_fdatasync)
#define __ver_filemap_fdatawait	d4250148
#define filemap_fdatawait	_set_ver(filemap_fdatawait)

in modules/filemap.ver

I'll have a look

