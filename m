Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from old-vger ([199.183.24.235]:10255 "EHLO unused")
	by vger.kernel.org with ESMTP id <S265138AbREMR3Y>;
	Sun, 13 May 2001 13:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143368AbREKTH6>; Fri, 11 May 2001 15:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143363AbREKTHw>; Fri, 11 May 2001 15:07:52 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:61704
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S143366AbREKTGB>; Fri, 11 May 2001 15:06:01 -0400
Date: Fri, 11 May 2001 15:04:22 -0400
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: hps@intermeta.de, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: reiserfs, xfs, ext2, ext3
Message-ID: <238390000.989607862@tiny>
In-Reply-To: <3AFBC643.42631F5C@namesys.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, May 11, 2001 04:00:20 AM -0700 Hans Reiser <reiser@namesys.com>
wrote:

> Alan Cox wrote:
> 
>> > Are you referring to Neil Brown's nfs operations patch as being as
>> > ugly as hell, or something else?  Just want to understand what you are
>> > saying before arguing.....
>> 
>> Andi has sent me some stuff to look at. He listed four implementations
>> and I've only seen two of them
> 
> did you see an implementation which adds operations to VFS and is written
> by Neil Brown (with reiserfs portions by Chris and Nikita)?

I coded up a mixture of Andi's 2.2.x apis and Neil's 2.4.x stuff and sent
it out for review a little while ago. It isn't as good as Neil's stuff, but
it doesn't require changing the other filesystems.  If it looked good to
the NFS guys and the other FS guys don't hate it, I'll push it around for
testing/inclusion.

This would be my preferred solution right now, since it could also work for
AFS.

-chris

