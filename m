Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUHZInK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUHZInK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267868AbUHZIkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:40:49 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:48309 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268021AbUHZIk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:40:29 -0400
Message-ID: <412DA1FD.4010507@namesys.com>
Date: Thu, 26 Aug 2004 01:40:29 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408252052420.13240-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408252052420.13240-100000@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>
>
>If your backup program dives into the file despite stat()
>saying it's a file and you restore your backup, how are the
>"file is a file" semantics preserved ?
>
>Obviously this is something that needs to be sorted out at
>the VFS layer.
>
It needs to be sorted out, whether it is sorted out at the VFS layer is 
unimportant.

>  A filesystem specific backup and restore
>program isn't desirable, if only because then there'd be
>no way for Hans's users to switch to reiser5 in 2010 ;)
>
>  
>
It might be that we need a filenameA/metas/backup method for all of our 
file plugins, which if cat'd gives a set of instructions which if 
executed are adequate for restoring filenameA.

Hans
