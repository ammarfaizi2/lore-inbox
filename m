Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbSJ2RQz>; Tue, 29 Oct 2002 12:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSJ2RQz>; Tue, 29 Oct 2002 12:16:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17673 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261972AbSJ2RQv>;
	Tue, 29 Oct 2002 12:16:51 -0500
Message-ID: <3DBEC3E6.9050908@pobox.com>
Date: Tue, 29 Oct 2002 12:22:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tytso@mit.edu
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] 2/11  Ext2/3 Updates: Extended attributes, ACL, etc.
References: <E186ZRR-0006tS-00@snap.thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu wrote:

>Ext2/3 forward compatibility: on-line resizing
>  
>
Is the interface for this going to be ext2meta?  Al and sct seemed to 
agree that that was the best way act upon the filesystem metadata while 
it's online...  I'll probably be updating that for 2.5.x VFS changes in 
a few weeks, that will provide safe online defrag and a good interface 
for other metadata interaction.

>This patch allows forward compatibility with future filesystems which
>are dynamically grown by using an alternate algorithm for storing the
>block group descriptors.  It's also a bit more efficient, in that it
>uses just a little bit less disk space.  Currently, the ext2 filesystem
>format requires either relocating the inode table, or reserving space in
>before doing the on-line resize.  The new scheme, which is documented in
>"Planned Extensions to the Ext2/3 Filesystem", by Stephen Tweedie and I (see:
>http://www.usenix.org/publications/library/proceedings/usenix02/tech/freenix/tso.html)
>  
>
It would be nice if this paper were available to everybody, and not 
passworded.

    Jeff




