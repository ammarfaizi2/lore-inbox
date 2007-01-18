Return-Path: <linux-kernel-owner+w=401wt.eu-S932754AbXARX1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbXARX1f (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 18:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbXARX1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 18:27:35 -0500
Received: from alpha.polcom.net ([83.143.162.52]:45590 "EHLO alpha.polcom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932754AbXARX1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 18:27:34 -0500
Date: Fri, 19 Jan 2007 00:27:17 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, aia21@cam.ac.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: NTFS
In-Reply-To: <20070118145439.b8d84d6b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0701190022540.17626@alpha.polcom.net>
References: <1169115951.5408.10.camel@imp.csi.cam.ac.uk>
 <20070118222243.GA14047@infradead.org> <20070118143506.4d007aad.akpm@osdl.org>
 <20070118223813.GA6589@infradead.org> <20070118145439.b8d84d6b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Andrew Morton wrote:
>> On Thu, 18 Jan 2007 22:38:13 +0000 Christoph Hellwig <hch@infradead.org> wrote:
>> On Thu, Jan 18, 2007 at 02:35:06PM -0800, Andrew Morton wrote:
>>>> Cool.  That means ->put_inode is gone in -mm.  Andrew, what are the
>>>> plans for sending the patches to make the ext2 preallocation work
>>>> like ext3 to Linus?
>>>
>>> Cautious.  I'm not sure that we ever want to merge them, really - ext2 is
>>> more a reference filesystem than a real one nowadays, and making it more
>>> complex detracts from that.
>>
>> The again while the old preallocation code might be simpler it's also utterly
>> braindead and we need to make sure no one is going to copy this :)
>
> Good point ;)

Are you refering to that particular implementation in ext2 or to the 
whole method od doing it implemented currently in ext2?

When can I read about it (description of the new method/implementation in 
ext3 and why is it better) some more?


Thanks,

Grzegorz Kulewski

