Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUGJFpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUGJFpx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 01:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUGJFpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 01:45:52 -0400
Received: from bigapple.newyorkcity.de ([192.76.147.50]:15505 "EHLO
	bigapple.newyorkcity.de") by vger.kernel.org with ESMTP
	id S266143AbUGJFpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 01:45:51 -0400
Date: Sat, 10 Jul 2004 07:45:27 +0200
From: Martin Ziegler <mz@newyorkcity.de>
To: Eric Lammerts <eric@lammerts.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS no longer working ?
Message-ID: <CF34124A9356CDBF3B8BBDC6@soho>
In-Reply-To: <Pine.LNX.4.58.0407100008020.19087@vivaldi.madbase.net>
References: <8232A615C6D0B05C09DBF242@soho>
 <Pine.LNX.4.58.0407100008020.19087@vivaldi.madbase.net>
X-Mailer: Mulberry/3.1.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

it's mentioned in Documentation/Changes. When i try to mount i get the 
message "mount: fs type nfsd not supported by kernel" although NFS is 
compiled into the kernel. Perhaps there is another option which have to be 
enabled but i just overseen it ?

Thanks

  Martin

--On Samstag, 10. Juli 2004 00:14 -0400 Eric Lammerts <eric@lammerts.org> 
wrote:

>
> On Fri, 9 Jul 2004, Martin Ziegler wrote:
>> just installed kernel version 2.6.7 on RedHat 8.0. Unfortunately i'm no
>> longer able to use NFS. Are there any recent issues ? For a detailed
>> problem description please see below. Any help is appreciated.
>
> I also had problems with NFS on 2.6.x (not the same as yours, though).
> The solution was to do "mount -t nfsd none /proc/fs/nfsd" on the
> server. You might wanna give that a try, maybe it'll help.
>
> Eric
>


