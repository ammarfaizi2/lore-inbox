Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288127AbSBOLpx>; Fri, 15 Feb 2002 06:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288614AbSBOLpo>; Fri, 15 Feb 2002 06:45:44 -0500
Received: from [195.63.194.11] ([195.63.194.11]:52231 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S288127AbSBOLpZ>; Fri, 15 Feb 2002 06:45:25 -0500
Message-ID: <3C6CF4AA.8040808@evision-ventures.com>
Date: Fri, 15 Feb 2002 12:44:42 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jakob =?ISO-8859-1?Q?=D8stergaard?= <jakob@unthought.net>
CC: Michael Sinz <msinz@wgate.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Core dump file control
In-Reply-To: <3C6BE18F.7B849129@wgate.com> <20020215124036.C23673@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Østergaard wrote:

>On Thu, Feb 14, 2002 at 11:10:55AM -0500, Michael Sinz wrote:
>
>>I have, for a long time, wished that Linux had a way to specify where
>>core dumps are stored and what the name of the core dump is.  Now that
>>I have been building large linux clusters with many diskless nodes,
>>this need has become even more important.
>>
>...
>
>I just wanted to throw in my 0.02 Euro on this one:
>
>I have not yet tested your patch yet - but this functionality is *very*
>important to my company as well.
>
>Anyone developing applications with multiple processes will benefit
>significantly from having core files named differnetly than just "core".
>
>A patch was included in the kernel some time ago, to allow the appending of the
>PID - however, this is not really good enough. It's better than nothing, but
>it's not good.
>
>What I want is "core.[process name]" eventually with a ".[pid]" appended.  A
>flexible scheme like your patch implements is very nice.   Actually having
>the core files in CWD is fine for me - I mainly care about the file name.
>

Please execute the size command on the core fiel:

size core

to see why this isn't needed.

>

