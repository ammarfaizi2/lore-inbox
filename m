Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264893AbSJ3Vbx>; Wed, 30 Oct 2002 16:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264896AbSJ3Vbx>; Wed, 30 Oct 2002 16:31:53 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:56774 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264893AbSJ3Vbw>;
	Wed, 30 Oct 2002 16:31:52 -0500
Message-ID: <3DC05104.2020504@colorfullife.com>
Date: Wed, 30 Oct 2002 22:37:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Bernhard Kaindl <bk@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPC SMP race: msgrcv may not return before msgsnd is
 done
References: <Pine.LNX.3.96.1021030162033.14229C-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[subject line switched back, sorry for the wrong line]

Bill Davidsen wrote:

>Don't know about his, my app does, it's only a benchmark, but I do see bad
>behaviour from time to time (total lockups) on SMP machines.
>
>  
>
Could you try Bernhard's patch? Lockless receive is nice, but fixing the 
found race would be really tricky, and is probably not worth the effort.

--
    Manfred


