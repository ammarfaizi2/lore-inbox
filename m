Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269685AbUHZWnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269685AbUHZWnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269760AbUHZWkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:40:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:4747 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S269696AbUHZWdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:33:38 -0400
Date: Thu, 26 Aug 2004 23:32:03 +0100
From: Chris Dukes <pakrat@www.uk.linux.org>
To: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       Christophe Saout <christophe@saout.de>, Rik van Riel <riel@redhat.com>,
       Jamie Lokier <jamie@shareable.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826223203.GD32697@ZenIV.linux.org.uk>
Mail-Followup-To: Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
	David Lang <david.lang@digitalinsight.com>,
	Christophe Saout <christophe@saout.de>,
	Rik van Riel <riel@redhat.com>, Jamie Lokier <jamie@shareable.org>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
	Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
	torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com> <1093536282.5482.6.camel@leto.cs.pocnet.net> <Pine.LNX.4.60.0408261348370.27825@dlang.diginsite.com> <200408270030.20647.lkml@felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408270030.20647.lkml@felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 12:30:19AM +0200, Felipe Alfaro Solana wrote:
> On Thursday 26 August 2004 23:05, David Lang wrote:
> 
> > I also don't see why the VFS/Filesystem can't decide that (for example)
> > this tar.gz is so active that instead of storing it as a tar.gz and
> > providing a virtual directory of the contents that it instead stores the
> > directory of the contents and makes the tar.gz virtual (regenerating it as
> > needed or as extra system resources are available)
> 
> Because that would mean the kernel should "talk" the tar format, which is, 
> IMHO, a Bad Idea (TM). Maybe the kernel could notify a user-space daemon to 
> perform this task, instead.

Wasn't HURD supposed to do this for us?
-- 
Chris Dukes
Warning: Do not use the reflow toaster oven to prepare foods after
it has been used for solder paste reflow. 
http://www.stencilsunlimited.com/stencil_article_page5.htm
