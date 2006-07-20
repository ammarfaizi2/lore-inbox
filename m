Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWGTW7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWGTW7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 18:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWGTW7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 18:59:11 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:7857 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030398AbWGTW7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 18:59:09 -0400
Message-ID: <44BFFCB1.4020009@namesys.com>
Date: Thu, 20 Jul 2006 15:59:13 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: reiserfs-list@namesys.com, LKML <linux-kernel@vger.kernel.org>
Subject: reiser4 status (correction)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it seems we still aren't quite as stable as we were 6 months ago 
(the new reduced cpu usage code was extensive, as was the VFS change 
code), and we know of a bug we can reproduce using our standard tests.  
Also, it seems we can oops when a particular program is run to consume 
all memory (thanks Jate for finding it).  Hopefully things will be more 
stable next week....  Us developers are using the new code on our 
workstations without problem though.

On a more positive note, Reiser4.1 is getting closer to release....  It 
is working fine for the developer coding it, and we are scheduling code 
reviews for it and defining migration paths, etc.  Hopefully in 2 months 
it will ship.

The big issue with 4.1 is that we are having to deal with all the issues 
of REALLY allowing users to change default plugins, etc., and finding we 
missed details.  We will say more later.

Thanks for your patience,

Hans
