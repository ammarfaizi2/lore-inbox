Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUHZJc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUHZJc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268378AbUHZJa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:30:59 -0400
Received: from verein.lst.de ([213.95.11.210]:54225 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266626AbUHZJYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:24:30 -0400
Date: Thu, 26 Aug 2004 11:24:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826092413.GA28854@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	Linus Torvalds <torvalds@osdl.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825201929.GA16855@lst.de> <412DA25E.9090405@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412DA25E.9090405@namesys.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:42:06AM -0700, Hans Reiser wrote:
> Christoph Hellwig wrote:
> 
> >
> >Over the last at least five years we've taken as much as possible
> >semantics out of the filesystems and into the VFS layer, thus having
> >a separation between the semantical layer (VFS) and the low level
> >filesystem.
> >
> VFS is the common filesystem layer.  The only reason you think semantics 
> belong in the common filesystem layer is that you are not innovating in 
> your semantics, and feel content with stasis.
> 
> I don't.  I expect that semantics will get radically changed over the 
> next few years as we compete with Giampaolo and whatever lesser lights 
> are working at Microsoft.

Hans, please stop the gooddamn personal attack bullshit.

How do you for example suggestion exporting your semantics over the
network if they're not done at the VFS level?  How do you want some
clusterfilesystem support them or tmpfs?

