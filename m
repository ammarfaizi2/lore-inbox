Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSEUSfK>; Tue, 21 May 2002 14:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSEUSfJ>; Tue, 21 May 2002 14:35:09 -0400
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:15065 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S315417AbSEUSfI>;
	Tue, 21 May 2002 14:35:08 -0400
Message-ID: <3CEA935B.2080005@tmsusa.com>
Date: Tue, 21 May 2002 11:35:07 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020520
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: suid bit on directories
In-Reply-To: <Pine.LNX.3.96.1020521140333.1427C-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

>On Mon, 20 May 2002, Dax Kelson wrote:
>
>  
>
>>On Mon, 20 May 2002, Dax Kelson wrote:
>>
>>    
>>
>>>Example 1:
>>>
>>>/home/bob/public_html
>>>
>>>public_html  is user/group  bob/httpd
>>>
>>>the perms are 2770
>>>      
>>>
>>I meant 4770 since we are discussing a hypothetical SUID directory.
>>    
>>
>
>I would expect public_html to be 4775 or 4771 if it's to be any use at all. Otherwise why have it?
>  
>

Yes, it would have to have httpd group ownership
or it would be totally inaccessible - and it would
be difficult for a non-root user to assign such grp
ownership....

Joe




