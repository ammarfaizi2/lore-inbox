Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbTHZUcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbTHZUcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:32:51 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:58040 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262904AbTHZUco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:32:44 -0400
Message-ID: <3F4BC357.7010106@namesys.com>
Date: Wed, 27 Aug 2003 00:30:15 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Steven Cole <elenstev@mesatop.com>, Oleg Drokin <green@namesys.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Alex Zarochentsev <zam@namesys.com>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 snapshot for August 26th.
References: <20030826102233.GA14647@namesys.com> <1061922037.1670.3.camel@spc9.esa.lanl.gov> <20030826182609.GO5448@backtop.namesys.com> <1061926566.1076.2.camel@teapot.felipe-alfaro.com> <20030826194321.GA25730@namesys.com> <1061927482.1666.36.camel@spc9.esa.lanl.gov> <20030826200530.GC1258@matchmail.com> <1061928831.1666.46.camel@spc9.esa.lanl.gov> <20030826202649.GD1258@matchmail.com>
In-Reply-To: <20030826202649.GD1258@matchmail.com>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

>On Tue, Aug 26, 2003 at 02:13:51PM -0600, Steven Cole wrote:
>  
>
>>On Tue, 2003-08-26 at 14:05, Mike Fedyk wrote:
>>    
>>
>>>Can you try ext3 with -o data=writeback, as well as xfs & reiser3?
>>>      
>>>
>>[root@spc1 /]# umount /dev/hda9
>>[root@spc1 /]# mount -t ext3 -o data=writeback /dev/hda9 /home
>>[root@spc1 /]# mount -t reiserfs /dev/hda10 /share_r
>>[root@spc1 /]# mount -t xfs /dev/hda12 /share_x
>>
>>    
>>
>
>Please use the same partition for all filesystem tests, otherwise you will
>be showing results that need to be adjusted for inner-spindle disk speed.
>
>
>  
>
Oh yes, Mike is right.

-- 
Hans


