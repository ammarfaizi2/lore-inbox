Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288112AbSATVxm>; Sun, 20 Jan 2002 16:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288089AbSATVxc>; Sun, 20 Jan 2002 16:53:32 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:32779 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288112AbSATVxU>; Sun, 20 Jan 2002 16:53:20 -0500
Message-ID: <3C4B3B67.60505@namesys.com>
Date: Mon, 21 Jan 2002 00:49:27 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201201936340.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Mon, 21 Jan 2002, Hans Reiser wrote:
>
>>>>and should otherwise check to see if the filesystem supports something
>>>>like pressure_fs_cache(), yes?
>>>>
>>>That's incompatible with the concept of memory zones.
>>>
>>Care to explain more?
>>
>
>On basically any machine we'll have multiple memory zones.
>
>Each of those memory zones has its own free list and each
>of the zones can get low on free pages independantly of the
>other zones.
>
>This means that if the VM asks to get a particular page
>freed, at the very minimum you need to make a page from the
>same zone freeable.
>
>regards,
>
>Rik
>

I'll discuss with Josh tomorrow how we might implement support for that. 
  A clean and simple mechanism does not come to my mind immediately.

Hans

