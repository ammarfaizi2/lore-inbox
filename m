Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269187AbUHZQMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269187AbUHZQMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269181AbUHZQKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:10:20 -0400
Received: from mail.shareable.org ([81.29.64.88]:27078 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269156AbUHZQGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:06:45 -0400
Date: Thu, 26 Aug 2004 17:06:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826160638.GJ5733@mail.shareable.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com> <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com> <20040826124119.GA431@lst.de> <20040826134812.GB5733@mail.shareable.org> <20040826155744.GA4250@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826155744.GA4250@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> > There's bound to be some security issue, but I'm not sure what you're
> > getting at with /tmp.  What sort of sort of security problem arises
> > with a world-writeable directory such as /tmp, that cannot arise with
> > the standard fs semantics?
> 
> Actually you are right on that issue because it would open the
> device/fifo as directory and not device/fifo (in fact I'd had to look at
> the code again to see whether they actually do this only for files or
> also for special files)

Are you saying that with reiser4, you can open a device or fifo with
O_DIRECTORY?

-- Jamie
