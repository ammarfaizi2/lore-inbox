Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267901AbUHZIsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267901AbUHZIsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUHZIpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:45:45 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:43191 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267920AbUHZImF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:42:05 -0400
Message-ID: <412DA25E.9090405@namesys.com>
Date: Thu, 26 Aug 2004 01:42:06 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825201929.GA16855@lst.de>
In-Reply-To: <20040825201929.GA16855@lst.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>
>Over the last at least five years we've taken as much as possible
>semantics out of the filesystems and into the VFS layer, thus having
>a separation between the semantical layer (VFS) and the low level
>filesystem.
>
VFS is the common filesystem layer.  The only reason you think semantics 
belong in the common filesystem layer is that you are not innovating in 
your semantics, and feel content with stasis.

I don't.  I expect that semantics will get radically changed over the 
next few years as we compete with Giampaolo and whatever lesser lights 
are working at Microsoft.

>  Your attributes are absoultely a VFS thing and as such
>should not happen at the filesystem layer, and no, that doesn't mean
>they're bad per se, I just think they are a rather bad fit for Linux.
>
>So now go on and try to work together with the other peope doing VFS
>level work instead of hiding, or if you think you can't work together
>with us search a nice research OS where you can take over the VFS layer,
>if your ideas prove to be good I'm sure Linux will pick them up sooner
>or later.
>
>	Christoph
>
>
>  
>
I tell you what, use xattrs for all the half speed filesystems, and the 
users and I will use metafiles.
