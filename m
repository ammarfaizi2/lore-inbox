Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUHYUXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUHYUXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268637AbUHYUXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:23:18 -0400
Received: from verein.lst.de ([213.95.11.210]:47554 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268541AbUHYUTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:19:35 -0400
Date: Wed, 25 Aug 2004 22:19:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825201929.GA16855@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	Linus Torvalds <torvalds@osdl.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825200859.GA16345@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, I just got reminded you might take my saying as an "piss of you're
idea stinks" or similar things.  So let me clarify again the actual
technical and project managment issues another time before we start
getting really personal :)

Over the last at least five years we've taken as much as possible
semantics out of the filesystems and into the VFS layer, thus having
a separation between the semantical layer (VFS) and the low level
filesystem.  Your attributes are absoultely a VFS thing and as such
should not happen at the filesystem layer, and no, that doesn't mean
they're bad per se, I just think they are a rather bad fit for Linux.

So now go on and try to work together with the other peope doing VFS
level work instead of hiding, or if you think you can't work together
with us search a nice research OS where you can take over the VFS layer,
if your ideas prove to be good I'm sure Linux will pick them up sooner
or later.

	Christoph
