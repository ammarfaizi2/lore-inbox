Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUHZIzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUHZIzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUHZIth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:49:37 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:45704 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267927AbUHZIna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:43:30 -0400
Message-ID: <412DA2B4.6030709@namesys.com>
Date: Thu, 26 Aug 2004 01:43:32 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825201929.GA16855@lst.de> <Pine.LNX.4.58.0408251323170.17766@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408251323170.17766@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Wed, 25 Aug 2004, Christoph Hellwig wrote:
>  
>
>>Over the last at least five years we've taken as much as possible
>>semantics out of the filesystems and into the VFS layer, thus having
>>a separation between the semantical layer (VFS) and the low level
>>filesystem.  Your attributes are absoultely a VFS thing and as such
>>should not happen at the filesystem layer, and no, that doesn't mean
>>they're bad per se, I just think they are a rather bad fit for Linux.
>>    
>>
>
>Now this I agree with, in the sense that I think that if we want to 
>support this, it should be supported at a VFS layer. 
>
>On the other hand, I think doing it inside the filesystem with ugly hacks 
>  
>
what is ugly? ;-/

>is an acceptable way to prototype the idea before it's been proven to 
>really be workable. Maybe it has more problems with legacy apps than we'd 
>expect..
>
>		Linus
>
>
>  
>

