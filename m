Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314787AbSEPVxC>; Thu, 16 May 2002 17:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314841AbSEPVxB>; Thu, 16 May 2002 17:53:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46340 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314787AbSEPVxB>; Thu, 16 May 2002 17:53:01 -0400
Subject: Re: [PATCH 2.4.19pre8][RFC] remove-NFS-close-to-open from VFS (was Re: [PATCHSET] 2.4.19-pre8-jp12)
To: joergprante@gmx.de
Date: Thu, 16 May 2002 23:13:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <200205162142.AWF00051@netmail.netcologne.de> from "=?iso-8859-15?q?J=F6rg=20Prante?=" at May 16, 2002 11:40:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178TUb-0005Bh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to leave the VFS layer untouched? Or restrict the dentry 
> revalidation to NFS and let other remote file systems coexist, i.e. without 
> revalidation calls? 

Really the other file systems want fixing - that revalidation is a real bug
fix and the situation could occur for other network file systems too
