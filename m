Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268110AbRG2TOd>; Sun, 29 Jul 2001 15:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268125AbRG2TOX>; Sun, 29 Jul 2001 15:14:23 -0400
Received: from james.kalifornia.com ([208.179.59.2]:28464 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S268110AbRG2TOO>; Sun, 29 Jul 2001 15:14:14 -0400
Message-ID: <3B646077.9000202@blue-labs.org>
Date: Sun, 29 Jul 2001 15:13:59 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010725
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Ehhh....

I unmounted a number of partitions with no userland errors...Maybe this 
could be changed to indicate which partition it was?  The odd part is I 
killed all processes on the suspect partition and umount returned busy 
however lsof indicated no files open on that partition.  A third 
invocation of umount got it to unmount.  This was a reiserfs partition 
btw.  The ext2 partition is /boot and e2fsck on it didn't yield any errors.

Kernel 2.4.7, ext2 and reiserfs partitions.

David


