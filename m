Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316363AbSEWTIe>; Thu, 23 May 2002 15:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316986AbSEWTId>; Thu, 23 May 2002 15:08:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:27151 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316363AbSEWTIc> convert rfc822-to-8bit; Thu, 23 May 2002 15:08:32 -0400
Message-ID: <3CED2F54.8000809@evision-ventures.com>
Date: Thu, 23 May 2002 20:05:08 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <mailman.1022085725.386.linux-kernel2news@redhat.com> <200205231707.g4NH74K06402@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Pete Zaitcev napisa³:
>>Anybody: if you've ever used /dev/ports, holler _now_.
>>
>>		Linus
> 
> 
> I often use it as an alternative to #include <asm/io.h>,
> which you decreed illegal. I understand <sys/io.h> is a legal
> alternative, but a bunch of platforms forget to
> include <sys/io.h>, for instance Jes cried bloody murder
> when asked to add it to ia-64. But if you decide to drop /dev/port
> I can tough it out. Solaris lives without it, and so can we.
> 
> I saw this whining about outl not implemented for
> write(fd, &my_int, 4), and I think the guy had a little point.
> Though if he wanted it, he ought to submit a patch.


Hey and finally if someone want's to use /dev/port for
developement on some slow control experimental hardware for example.
Why doesn't he just delete the - signs at the front lines
of the patch deleting it plus module register/unregister trivia and
compile it as a *separate* character device module ?
That's linux - you have the source, so use it.
You wan't to cheat around the OS abstractions - do it for yourself!
There is no requirement that it has to be
permanently in the mainline kernel where it tends to
attract people who shouldn't have used it in first place
for generic stuff like kbd rate settings and clock device
manipulation.

