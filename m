Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSJCTja>; Thu, 3 Oct 2002 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSJCTja>; Thu, 3 Oct 2002 15:39:30 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:47365 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261295AbSJCTja>; Thu, 3 Oct 2002 15:39:30 -0400
Message-ID: <3D9C9E39.6090804@namesys.com>
Date: Thu, 03 Oct 2002 23:44:57 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: G@thunk.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on
 2.5.40-mm1
References: <20021001195914.GC6318@stingr.net> <20021001204330.GO3000@clusterfs.com> <20021002104859.GD6318@stingr.net> <20021002165454.GV3000@clusterfs.com> <20021003003739.GA4381@think.thunk.org> <3D9C323C.1050504@namesys.com> <20021003194049.GA16329@think.thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Thu, Oct 03, 2002 at 04:04:12PM +0400, Hans Reiser wrote:
>  
>
>>No they don't.  Average space wastage is more than 50% because sysadmins 
>>have to be conservative.
>>    
>>
>
>Sure, but even a hundred megabytes or two out of a 100 gigabyte drive
>is cheap.  (Specifically, about fifty cents' worth.)
>
>						- Ted
>
>
>  
>
Usual space wastage is on the order of 5% of total partition size, yes? 
 Allocating 0.1% of your drive for inodes will get you into trouble if a 
user does something like use mh or read news, etc.


