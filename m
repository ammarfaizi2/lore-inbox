Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279378AbRKGBHU>; Tue, 6 Nov 2001 20:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279399AbRKGBHK>; Tue, 6 Nov 2001 20:07:10 -0500
Received: from bacon.van.m-l.org ([208.223.154.200]:9088 "EHLO
	bacon.van.m-l.org") by vger.kernel.org with ESMTP
	id <S279378AbRKGBG7>; Tue, 6 Nov 2001 20:06:59 -0500
Date: Tue, 6 Nov 2001 20:06:48 -0500 (EST)
From: George Greer <greerga@m-l.org>
X-X-Sender: <greerga@bacon.van.m-l.org>
To: <dank@trellisinc.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011106194923.D6AB1A3C19@fancypants.trellisinc.com>
Message-ID: <Pine.LNX.4.33.0111062004040.1649-100000@bacon.van.m-l.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001 dank@trellisinc.com wrote:

>In article <20011105155955.A16505@codepoet.org> Erik Anderson wrote:
>> Come now, it really isn't that difficult: 
>
>>    char name[80];
>>    if (sscanf(line, "%4u %4u %llu %s", &major, &minor, &size, name) == 4)
>
>if it's so easy to do, why do you have a great big buffer overflow here?

Because he forgot about "%80s"?  But if he forgot that he may accidently
use strcpy, strcat, and gets, so...

Or maybe it was just an exercise for the reader?

-- 
George Greer, greerga@m-l.org
http://www.m-l.org/~greerga/


