Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286227AbRL0Jtc>; Thu, 27 Dec 2001 04:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286229AbRL0JtX>; Thu, 27 Dec 2001 04:49:23 -0500
Received: from [195.63.194.11] ([195.63.194.11]:26886 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S286227AbRL0JtG>; Thu, 27 Dec 2001 04:49:06 -0500
Message-ID: <3C2AEBA8.809@evision-ventures.com>
Date: Thu, 27 Dec 2001 10:36:40 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011212
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Bill Huey <billh@tierra.ucsd.edu>
CC: "David S. Miller" <davem@redhat.com>, kerndev@sc-software.com,
        bcrl@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org
Subject: Re: aio
In-Reply-To: <20011219.184527.31638196.davem@redhat.com> <Pine.LNX.3.95.1011219184950.581H-100000@scsoftware.sc-software.com> <20011219.190629.03111291.davem@redhat.com> <20011219192105.B26007@burn.ucsd.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey wrote:

>On Wed, Dec 19, 2001 at 07:06:29PM -0800, David S. Miller wrote:
>
>>Firstly, you say this as if server java applets do not function at all
>>or with acceptable performance today.  That is not true for the vast
>>majority of cases.
>>
>>If java server applet performance in all cases is dependent upon AIO
>>(it is not), that would be pretty sad.  But it wouldn't be the first
>>
>
>Java is pretty incomplete in this area, which should be addressed to a
>great degree in the new NIO API.
>
>The core JVM isn't dependent on this stuff per se for performance, but
>it is critical to server side programs that have to deal with highly
>scalable IO systems, largely number of FDs, that go beyond the current
>expressiveness of select()/poll().
>
>This is all standard fare in *any* kind of high performance networking
>application where some kind of high performance kernel/userspace event
>delivery system is needed, kqueue() principally.
>
>>time I've heard crap like that.  There is propaganda out there telling
>>people that 64-bit address spaces are needed for good java
>>performance.  Guess where that came from?  (hint: they invented java
>>and are in the buisness of selling 64-bit RISC processors)
>>
>
>What ? oh god. HotSpot is a pretty amazing compiler and it performs well.
>Swing does well now, but the lingering issue in Java is the shear size
>of it and possibly GC issues. It pretty clear that it's going to get
>larger, which is fine since memory is cheap.
>
I remind you: ORACLE 9i is requiring half a gig as a minimum just due to the
use of the CRAPPY PIECE OF SHIT written in the Java, called, you guess 
it: Just the
bloody damn Installer. Java is really condemned just due to the fact 
that both terms: speed
and memmory usage are both allways only *relative* to other systems.

And yes GC's have only one problem - they try to give a general solution 
for problems
which can be easly prooven to be mathmematically insolvable. The 
resulting undeterministic
behaviour of applications is indeed the thing which is hurting most.

