Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSGZEuU>; Fri, 26 Jul 2002 00:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSGZEuT>; Fri, 26 Jul 2002 00:50:19 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60677 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316789AbSGZEuR>; Fri, 26 Jul 2002 00:50:17 -0400
Message-ID: <3D3AF6E0.2040107@evision.ag>
Date: Sun, 21 Jul 2002 20:01:04 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Rik van Riel <riel@conectiva.com.br>,
       Andreas Dilger <adilger@clusterfs.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST]
References: <Pine.LNX.4.44L.0207192207060.12241-100000@imladris.surriel.com> <3D38C31F.6030804@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Rik van Riel wrote:
> 
>> On Sat, 20 Jul 2002, Hans Reiser wrote:
>>
>>  
>>
>>> What I was advocating was a schedule of:
>>> 1) feature submission deadline
>>> 2) period of working through feature backlog
>>> 3) feature acceptance ending date
>>>   
>>
>>
>> So, what feature are you trying to smuggle into the kernel
>> but are afraid isn't ready on time and why do you think it
>> couldn't be backported into 2.6 later, when 2.6 is stable ?
>>
> Ouch.  He sees right though me.;)
> 
> The core Reiser4 code should be in time.  Reiser4 will have its core 
> code stable in a month I hope, and by core code I mean code that does 
> what V3 does but on top of a plugin infrastructure and faster than V3 in 
> at least some measures. 
> What I am worried about schedule-wise are:
> 
> * the API for exporting transactions to user space (the in kernel buffer 
> management code to support it is completed but the API is not yet done). 
> Uses the new system call we are adding.
> 
> * The traditional file API is designed for efficiency of repeated 
> operations to the same file.  As part of our effort to make files able 
> to do everything that extended attributes can do, but more flexibly, we 
> are creating a new system call.  This new system call can perform 
> multiple operations on files in one system call, and is very convenient 
> for a bunch of small IOs to different files.
> 
> * file inheritance
> 
> Some other reiser4 things won't make it, but they seem like they should 
> be easier to get in later because they are plugins:
> 
> * encryption plugin
> 
> * ACL plugin
> 
> * audit plugin

I strongly oppose OSes with mutating semantics and don't like the
"plugin" idea at all therefore.


