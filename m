Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSHARjf>; Thu, 1 Aug 2002 13:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSHARjf>; Thu, 1 Aug 2002 13:39:35 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:37903 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S316499AbSHARje>; Thu, 1 Aug 2002 13:39:34 -0400
Date: Thu, 1 Aug 2002 18:42:52 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: network driver informations [general NIC, Wireless and e100]
Message-ID: <20020801174252.GA58488@compsoc.man.ac.uk>
References: <20020731212426.GA3342@schottelius.org> <3D492531.9030905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D492531.9030905@mandrakesoft.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
X-Scanner: exiscan *17aJyR-00047S-00*hQbiD0BUf2s* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 08:10:25AM -0400, Jeff Garzik wrote:

> Al Viro has talked about, long term, making this information available 
> through a filesystem.  When that happens, your request will have 
> basically been implemented.

It would probably help if some of the basic code needed was wrapped in
an even more "dumbed-down" API - most of the stuff in say pcihpfs is
generically useful for this sort of configfs thing.

As more and more minifs's appear (they are trivially easy to write after
all) we're likely to see more duplication of this code, and the
resultant missing bug fix propogation

regards
john

-- 
"The simpler it is, the harder it is." 
	- Tim Van Holder
