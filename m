Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbTDVUgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTDVUgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:36:32 -0400
Received: from watch.techsource.com ([209.208.48.130]:31207 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263845AbTDVUgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:36:23 -0400
Message-ID: <3EA5AE62.1040706@techsource.com>
Date: Tue, 22 Apr 2003 17:04:34 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can one build 2.5.68 with allyesconfig?
References: <3EA5AABF.4090303@techsource.com> <200304222041.h3MKfILq027562@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:

>On Tue, 22 Apr 2003 16:49:03 EDT, Timothy Miller <miller@techsource.com>  said:
>  
>
>>Is anyone else able to build 2.5.68 with allyesconfig?
>>
>>I'm using RH7.2, so the first thing I did was edit the main Makefile to 
>>replace gcc with "gcc3" (3.0.4).  Maybe the compiler is STILL my 
>>
>>    
>>
>
>1) I think the 3.0.4 compiler had some issues - 3.2.2 may be a better idea.
>  
>
Great.  Why do I have a feeling that installing it will bork my 
workstation?  Not to say that it can't be done but that I will probably 
screw it up.  I'm sure that Red Hat (7.2) has some dependencies on there 
being 2.96 installed.  Any suggestions on how I might deal with this 
problem?

>2) allyesconfig is probably NOT able to build an actual kernel that will
>work - in particular, there are a number of pairs/sets of drivers that are
>mutually exclusive for a given device. And as you noticed, allyesconfig
>will try to build stuff that's known to be b0rken.
>
I'm not actually going to run the kernel.

>
>3) Even if it works, it will be a huge kernel with lots of stuff you almost
>certainly don't need (got an ISDN card? I didn't think so ;).  You would more
>likely want to customize the kernel for what you need, or at least consider
>using 'allmodconfig' so you can insmod the parts you need and skip the rest.
>  
>
I'm trying to do an allyesconfig kernel so that I can get all printk 
format strings.


