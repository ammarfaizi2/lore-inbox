Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTIMAq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTIMAq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:46:56 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:9179 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261962AbTIMAqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:46:54 -0400
Message-ID: <3F6268FD.6070104@namesys.com>
Date: Sat, 13 Sep 2003 04:46:53 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Kyle Rose <krose+linux-kernel@krose.org>, Oleg Drokin <green@namesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
References: <87r82noyr9.fsf@nausicaa.krose.org> <20030912153935.GA2693@namesys.com> <20030912175917.GB30584@matchmail.com> <20030912184001.GA9245@namesys.com> <20030912205446.GD30584@matchmail.com> <87ekylg1kb.fsf@nausicaa.krose.org> <20030912215631.GH30584@matchmail.com>
In-Reply-To: <20030912215631.GH30584@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

>On Fri, Sep 12, 2003 at 05:05:24PM -0400, Kyle Rose wrote:
>  
>
>>>Does this affect 2.4 also?
>>>      
>>>
>>As I said, this did not affect 2.4, at least not uniformly: I
>>regularly created DVD ISO images larger than 4GB under 2.4.2{0,1,2}
>>without problems.
>>    
>>
>
>Ok, thanks.  I'm glad it wasn't in 2.4
>
>EOST
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
It was a bug in Oleg's large write patch, which it seems was truly for 
2.5 only.....

-- 
Hans


