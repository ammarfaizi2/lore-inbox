Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268806AbUHLVm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268806AbUHLVm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268813AbUHLVj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:39:27 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:32749 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268807AbUHLVdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:33:06 -0400
Date: Thu, 12 Aug 2004 14:33:01 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove whitespace from ALI15x3 IDE driver name
Message-ID: <20040812213301.GA5876@plexity.net>
Reply-To: dsaxena@plexity.net
References: <1092336877.7433.1.camel@localhost> <20040812170400.A2448@infradead.org> <1092340343.22362.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092340343.22362.8.camel@localhost.localdomain>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 12 2004, at 20:55, Alan Cox was caught saying:
> On Iau, 2004-08-12 at 17:04, Christoph Hellwig wrote:
> > On Thu, Aug 12, 2004 at 06:54:38PM +0000, Pekka Enberg wrote:
> > > This patch removes whitespace from ALI15x3 IDE driver name that appears in the
> > > sysfs directory. It is against 2.6.7.
> > 
> > You jnow that this breaks every tool that knew of the names so far?  E.g.
> > Debian mkinitrd (now has a patch to deal with both the whitespace and
> > non-whitespace variants) and probably quite a few installers out there.
> 
> Greg okayed a pile of other related changes including some that were not
> just white space to _ but changed the actual string. So you may want to
> take it up with Greg rather than Pekka who is just filling in one that
> was missed

Not having touched installer code, can someone enlighten me on
why the installer would break with 's/ /_' or any other change
to driver name?

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
