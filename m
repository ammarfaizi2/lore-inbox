Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288277AbSATLWe>; Sun, 20 Jan 2002 06:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288245AbSATLW1>; Sun, 20 Jan 2002 06:22:27 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:58382 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288277AbSATLWO>; Sun, 20 Jan 2002 06:22:14 -0500
Message-ID: <3C4AA77E.1090408@namesys.com>
Date: Sun, 20 Jan 2002 14:18:22 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: refuse7@poczta.fm, linux-kernel@vger.kernel.org
Subject: Re: reiserFS undeletion
In-Reply-To: <20020119121610.DD9D02B5D9@pa160.grajewo.sdi.tpnet.pl> <20020119172934.4240F2B5D9@pa160.grajewo.sdi.tpnet.pl> <001301c1a11a$79884580$0201a8c0@HOMER> <20020119224504.6470F2BB61@pa160.grajewo.sdi.tpnet.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gniazdowski wrote:

>19 Jan 2002 19:52, Martin Eriksson wrote:
>
>>>19 Jan 2002 17:41, Hans Reiser wrote:
>>>
>>>>we only log metadata.
>>>>
>>>I know. Butt if i delete some file, it dosnt mean i set zero on sectors
>>>on disk. So imvho all is needet is meta data.
>>>
>>Yes, but (not butt =) if you have done some other file operations after the
>>delete, your deleted file might have been overwritten by another file.
>>Especially if you have little free space on your hard disk.
>>
>
>Yep but ( ;)  80% situations is like "ups i deleted it" and undeletion 
>operation is taken straight after that. So it would be nice to have it... 
>Just a sugestion...
>
>Regards Gniazdowski.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
yes, it would be nice, and patches to create a /..graves (notice the 
copyright avoidance naming scheme, and the opportunity for the gui guys 
to have some fun) will be accepted by me (though whether they will get 
past Linus I don't know, I think he prefers that libc do it, so I 
suggest making it a patch to libc.)

Hans


