Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283775AbRK3UTC>; Fri, 30 Nov 2001 15:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283776AbRK3USy>; Fri, 30 Nov 2001 15:18:54 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:43908 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S283775AbRK3USp> convert rfc822-to-8bit; Fri, 30 Nov 2001 15:18:45 -0500
Message-ID: <3C07E967.5A931F41@randomlogic.com>
Date: Fri, 30 Nov 2001 12:17:43 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kplug-list@kernel-panic.org
CC: kplug-lpsg@kernel-panic.org, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <E169tj8-00055G-00@DervishD.viadomus.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Raúl Núñez de Arenas Coronado" wrote:
> 
> >Hungarian notation???
> >That was developed by programmers with apparently no skill to
> >see/remember how a variable is defined.  IMHO in the Linux community
> >it's widely considered one of the worst coding styles possible.
> 
>     Not at all... Hungarian notation is not so bad, except it is only
> understood by people from hungary. So the name }:))) I just use it
> when I write code for Hungary or secret code that no one should
> read...

I prefer Pig Latin myself. ;)

> 
> >>  - Short variable/function names that someone thinks is descriptive but
> >> really isn't.
> >not all variable names need their purpose obvious to complete newbies.
> >sometimes it takes time to understand the code's purpose, in which case
> >the variable names become incredibly descriptive.
> 
>     Here you are right. The code can be seen really as a book: you
> can start reading at the middle and yet understand some of the story,
> but it's far better when you start at the beginning ;))) Moreover,
> most of the variable and function names in the kernel code are quite
> descriptive, IMHO.
> 

There's no way on earth I would ever start reading at the beginning of 3
million lines of code just so I can understand bobsdriver.o, which is
only 10,000 lines. I should not have to start at the beginning of
bobsdrvier.o either if I only needed to solve one problem in one
function somewhere near the end of it.

I have worked on several large projects and have rarely known how every
piece of any of them worked. I didn't have to. I only needed to know
about the portion(s) I was responsible for. I was able to do that with
the better projects because they were commented correctly and were
rather self documenting.

>     Of course, more comments and more descriptive names doesn't harm,
> but some times they bloat the code...
> 

Actually it bloats the source (we all know C++ bloats the resulting code
;), but what's wrong with that? At least a person can understand what's
going on and get to coding, instead of deciphering.

PGA
-- 
Paul G. Allen
UNIX Admin II ('til Dec. 3)/FlUnKy At LaRgE (forever!)
Akamai Technologies, Inc.
www.akamai.com
