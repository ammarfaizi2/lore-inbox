Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTLXXJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 18:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTLXXJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 18:09:11 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:29133 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264095AbTLXXJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 18:09:08 -0500
Message-ID: <3FEA1C91.2010302@labs.fujitsu.com>
Date: Thu, 25 Dec 2003 08:09:05 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <3FDD7DFD.7020306@labs.fujitsu.com>	 <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov>		 <3FDF95EB.2080903@labs.fujitsu.com> <3FE0E5C6.5040008@labs.fujitsu.com>	 <1071782986.3666.323.camel@sisko.scot.redhat.com>	 <3FE62999.90309@labs.fujitsu.com>  <3FE67362.2070704@labs.fujitsu.com> <1072094621.1967.6.camel@sisko.scot.redhat.com> <3FE8F079.7010906@labs.fujitsu.com>
In-Reply-To: <3FE8F079.7010906@labs.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tsuchiya Yoshihiro wrote:

>>OK, I'll try your script with a 2.4.21 or 2.4.23 kernel to see if we can
>>reproduce this here.  In the mean time, could you possibly try a 2.4.24
>>kernel, just in case the clear_inode race has something to do with this?
>>
>> 
>>
>>    
>>
>Stephen, I started running the test on ext2 and ext3 on 2.4.24-pre2.
>  
>
The test on ext3 on 2.4.24-pre2 failed. The read-only directory has been 
gone.
As from the number of files and blocks that 'df' says, not only the lost 
directory
has been gone, it looks the directories and files under it also have 
been gone.
The remove command looks like it really worked on the directory, rather than
the parent directory is broken.

The test on ext2 is still running.

Thanks,
Yoshi
---
Yoshihiro Tsuchiya

