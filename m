Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314079AbSEXBQD>; Thu, 23 May 2002 21:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317067AbSEXBQC>; Thu, 23 May 2002 21:16:02 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:4878 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317066AbSEXBQB>; Thu, 23 May 2002 21:16:01 -0400
Date: Fri, 24 May 2002 03:15:59 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre8-ac5: cannot mount FreeBSD file system
Message-ID: <20020524011559.GA7634@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to mount my FreeBSD 4.6-RC ufs file systems (softupdates enabled,
FWIW), I get this:

May 24 03:14:13 merlin kernel: ufs_read_super: fragment size 1024 is too
large

My UFS is compiled for read-only mode, and my command line is:
sudo mount -v -t ufs -r -o ufstype=44bsd  /dev/hdd14 /bsd/

With some older kernel (maybe before 2.4.18), it could be mounted.

-- 
Matthias Andree
