Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270370AbTHGPDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270256AbTHGPDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:03:04 -0400
Received: from visp12-175.visp.co.nz ([210.54.175.12]:28934 "EHLO
	mdew.dyndns.org") by vger.kernel.org with ESMTP id S275392AbTHGPB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:01:29 -0400
Subject: Re: reiserfs4
From: mdew <mdew@mdew.dyndns.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Oleg Drokin <green@namesys.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
       Andreas Dilger <adilger@clusterfs.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030807132111.GB7094@louise.pinerecords.com>
References: <200308070305.51868.vlad@lazarenko.net>
	 <20030806230220.I7752@schatzie.adilger.int> <3F31DFCC.6040504@cornell.edu>
	 <20030807072751.GA23912@namesys.com>
	 <20030807132111.GB7094@louise.pinerecords.com>
Content-Type: text/plain
Message-Id: <1060268478.30293.14.camel@mdew>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 08 Aug 2003 03:01:19 +1200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-08 at 01:21, Tomas Szepe wrote:

> > This is no longer true.
> > There is sort of "universal" fs convertor for linux that can convert almost
> > any fs to almost any other fs.
> > The only requirement seems to be that both fs types should have read/write support in Linux.
> > http://tzukanov.narod.ru/convertfs/
> 
> I'm afraid I cannot recommend using this tool.
> 
> A test conversion from reiserfs to ext3 (inside a vmware machine)
> screwed up the data real horrorshow: directory structure seems
> ok but file contents are apparently shifted.

I'm looking at converting (sometime soon) a JFS system to XFS using
convertfs, I'm hoping this "converting" process will come out bug-free. 
Other than backing up all the data, and re-formating to XFS, would any
one have suggestings?

convertfs /dev/hde1 jfs xfs

-- 
mdew <mdew@mdew.dyndns.org>

