Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262556AbSJGSyY>; Mon, 7 Oct 2002 14:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262563AbSJGSyY>; Mon, 7 Oct 2002 14:54:24 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:35745 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S262556AbSJGSyT>; Mon, 7 Oct 2002 14:54:19 -0400
Message-ID: <3DA1D969.8050005@nortelnetworks.com>
Date: Mon, 07 Oct 2002 14:58:49 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <E17ybuZ-0003tz-00@starship> <3DA1D30E.B3255E7D@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Go into ext2_new_inode, replace the call to find_group_dir with
> find_group_other.  Then untar a kernel tree, unmount the fs,
> remount it and see how long it takes to do a
> 
> 	`find . -type f  xargs cat > /dev/null'
> 
> on that tree.  If your disk is like my disk, you will achieve
> full disk bandwidth.

Pardon my ignorance, but what's the difference between find_group_dir 
and find_group_other, and why aren't we using find_group_other already 
if its so much faster?

Chris

