Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313123AbSDTATG>; Fri, 19 Apr 2002 20:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313669AbSDTATF>; Fri, 19 Apr 2002 20:19:05 -0400
Received: from terminus.zytor.com ([64.158.222.227]:51422 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S313123AbSDTATE>; Fri, 19 Apr 2002 20:19:04 -0400
Message-ID: <3604.131.107.184.74.1019261941.squirrel@www.zytor.com>
Date: Fri, 19 Apr 2002 17:19:01 -0700 (PDT)
Subject: Re: [PATCH] Re: SSE related security hole
From: "H. Peter Anvin" <hpa@zytor.com>
To: <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0204191708360.6542-100000@home.transmeta.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <hpa@zytor.com>, <bgerst@didntduck.org>, <andrea@suse.de>, <ak@suse.de>,
        <linux-kernel@vger.kernel.org>, <jh@suse.cz>
X-Mailer: SquirrelMail (version 1.2.5)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
> On Fri, 19 Apr 2002, H. Peter Anvin wrote:
>>
>> Indeed.  Logically, FNINIT should have been extended to initialize it
>> all - - it is a security hole that it doesn't initialize MMX properly.
>
> Well, MMX should arguably be initialized with "emms", so the proper
> sequence migth be something like
>

Remember that one of the original design goals of MMX was to run on
unmodified operating systems (and it can't be turned off); thus needing
any extra initialization is a bug.

    -hpa



