Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTJNGNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 02:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTJNGNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 02:13:14 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:58341 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261879AbTJNGNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 02:13:13 -0400
Message-ID: <3F8B93F7.2020805@namesys.com>
Date: Tue, 14 Oct 2003 10:13:11 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jw@pegasys.ws, linux-kernel@vger.kernel.org, vs@thebsh.namesys.com,
       nikita@namesys.com
Subject: Re: ReiserFS patch for updating ctimes of renamed files
References: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu>	<20031012071447.GJ8724@pegasys.ws>	<3F8A3CE0.4060705@namesys.com> <20031013032431.1ed40c25.akpm@osdl.org>
In-Reply-To: <20031013032431.1ed40c25.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>In theory it is cleaner and purer to do it the way we did.  In practice, 
>> Alex's problem seems like a real one, and I don't know how hard it is to 
>> change tar to do the right thing.  We'll discuss it in a small seminar 
>> today.
>>    
>>
>
>It would be best to make this change.  minix, ext2 and ext3 do set ctime,
>so it is "the Linux standard".
>
>
>
>
>  
>
do you think schultz's arguments about why it is wrong are correct?  
They seem well thought out to me.

-- 
Hans


