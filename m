Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279674AbRKFUUn>; Tue, 6 Nov 2001 15:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280524AbRKFUUd>; Tue, 6 Nov 2001 15:20:33 -0500
Received: from user-119a3cr.biz.mindspring.com ([66.149.13.155]:62220 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S280517AbRKFUUY>; Tue, 6 Nov 2001 15:20:24 -0500
From: dank@trellisinc.com
To: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011105155955.A16505@codepoet.org>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19ext3 (i686))
Message-Id: <20011106194923.D6AB1A3C19@fancypants.trellisinc.com>
Date: Tue,  6 Nov 2001 14:49:23 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011105155955.A16505@codepoet.org> Erik Anderson wrote:
> Come now, it really isn't that difficult: 

>    char name[80];
>    if (sscanf(line, "%4u %4u %llu %s", &major, &minor, &size, name) == 4)

if it's so easy to do, why do you have a great big buffer overflow here?

-- 
nicholas black (dank@trellisinc.com)    developer, trellis network security
