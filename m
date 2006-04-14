Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWDNJXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWDNJXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 05:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWDNJXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 05:23:45 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:28384 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965122AbWDNJXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 05:23:44 -0400
Message-ID: <208e01c65fa5$17a3c850$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Andreas Dilger" <adilger@clusterfs.com>, "Mingming Cao" <cmm@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <Ext2-devel@lists.sourceforge.net>
References: <20060413160657sho@rifu.tnes.nec.co.jp> <20060413171445.GT17364@schatzie.adilger.int>
Subject: Re: [Ext2-devel] [RFC][8/21]ext3 modify variables to exceed 2G
Date: Fri, 14 Apr 2006 18:23:24 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment, Andreas.

> Takashi-san, please, it would make the code much more maintainable if the
> changes made here would use new types for filesystem-wide block offsets
> and for file-relative block offsets, as was previously discussed, instead
> of just changing some variables to be unsigned long.  Like:
> 
> typedef unsigned long ext3_fsblk_t; # block offset in the filesystem
> typedef unsigned long ext3_fscnt_t; # block count in the filesystem
> typedef unsigned long ext3_fileblk_t; # block offset in a file

I agree that, but it will need a lots of work...
Mingming, you got same comment from Andreas in "Extend ext3
filesystem limit from 8TB to 16TB", did you do something about
this?

Cheers, sho
