Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271420AbTHHQYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271686AbTHHQYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:24:07 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:18142 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S271420AbTHHQYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:24:05 -0400
Date: Fri, 8 Aug 2003 18:23:31 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Oleg Drokin <green@namesys.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs4
Message-ID: <20030808162331.GB16208@louise.pinerecords.com>
References: <200308070305.51868.vlad@lazarenko.net> <20030806230220.I7752@schatzie.adilger.int> <3F31DFCC.6040504@cornell.edu> <20030807072751.GA23912@namesys.com> <20030807132111.GB7094@louise.pinerecords.com> <3F33A00B.2090502@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F33A00B.2090502@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [reiser@namesys.com]
> 
> Tomas Szepe wrote:
> 
> >I'm afraid I cannot recommend using this tool.
> >
> >A test conversion from reiserfs to ext3 (inside a vmware machine)
> >screwed up the data real horrorshow: directory structure seems
> >ok but file contents are apparently shifted.
> >
> Are you sure that vmware does not affect the result?

No, I can't be sure.  (Nevertheless I'm inclined to believe
this is rather a FIBMAP related kernel bug that has been
introduced after the current version of the convertfs toolset
was released in March 2002.)

Unfortunately at the moment I don't have a scratch partition
on any of my disks so I can't re-test on a live system.

-- 
Tomas Szepe <szepe@pinerecords.com>
