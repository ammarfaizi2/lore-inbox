Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269170AbUH0DD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269170AbUH0DD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 23:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269379AbUHZSxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:53:18 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:34788 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269304AbUHZSp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:45:57 -0400
Message-ID: <412E2FE5.1020606@namesys.com>
Date: Thu, 26 Aug 2004 11:45:57 -0700
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
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825201929.GA16855@lst.de> <412DA25E.9090405@namesys.com> <20040826092413.GA28854@lst.de>
In-Reply-To: <20040826092413.GA28854@lst.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>
>
>How do you for example suggestion exporting your semantics over the
>network if they're not done at the VFS level?  How do you want some
>clusterfilesystem support them or tmpfs?
>
>
>  
>
by accesses to filename/metas.....

That's the beauty of simplicity, not much is needed.  xattrs on the 
other hand would be a lot of work to integrate into a cluster filesystem.

Hans
