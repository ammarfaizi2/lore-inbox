Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275337AbTHGNju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275314AbTHGNju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:39:50 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:46299 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S275337AbTHGNic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:38:32 -0400
Date: Thu, 7 Aug 2003 15:21:11 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Oleg Drokin <green@namesys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org
Subject: Re: reiserfs4
Message-ID: <20030807132111.GB7094@louise.pinerecords.com>
References: <200308070305.51868.vlad@lazarenko.net> <20030806230220.I7752@schatzie.adilger.int> <3F31DFCC.6040504@cornell.edu> <20030807072751.GA23912@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807072751.GA23912@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [green@namesys.com]
> 
> > >Why do people ever want a "converter"?
> > That's been discussed before.
> > Because people don't have the resources (hard disk space, tape drives, 
> > money)  to backup their data, and might still be interested in testing a 
> > new filesystem. They might be willing to take a risk with the new fs 
> > and converter. Amazing as it may sound, people do that. I am such a 
> > tester, and I'd find a converter to be a useful tool. But since the 
> > previous discussion on the subject concluded it'd be really hard to 
> > impossible to write one, I guess I'll have to settle for new hard drive(s).
> 
> This is no longer true.
> There is sort of "universal" fs convertor for linux that can convert almost
> any fs to almost any other fs.
> The only requirement seems to be that both fs types should have read/write support in Linux.
> http://tzukanov.narod.ru/convertfs/

I'm afraid I cannot recommend using this tool.

A test conversion from reiserfs to ext3 (inside a vmware machine)
screwed up the data real horrorshow: directory structure seems
ok but file contents are apparently shifted.

-- 
Tomas Szepe <szepe@pinerecords.com>
