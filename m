Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289444AbSAJNqo>; Thu, 10 Jan 2002 08:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289443AbSAJNqf>; Thu, 10 Jan 2002 08:46:35 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:52490 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S289444AbSAJNqX>;
	Thu, 10 Jan 2002 08:46:23 -0500
Date: Thu, 10 Jan 2002 14:46:19 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Simple local DOS
To: matthias.andree@stud.uni-dortmund.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3C3D9B2B.2DDB72CB@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree (matthias.andree@stud.uni-dortmund.de) wrote :

> On Wed, 09 Jan 2002, David Balazic wrote: 
> 
> > 
> > log in on some virtual terminal, then run the following line 
> > in a bourne type shell, like bash : 
> > 
> > X 2>&1 | less 
> > 
> > A reboot "fixes" it. We want to reach windows level quality on desktop 
> > after all, don't we ? 
> 
> You can also fix that by a remote login,

How do I pull a network connection and a terminal out of a hat ?
Where do I get the hat ?
read : it is a sandalone system.

> chvt,

how do I start chvt if I have a locked up console system ?

> or by just not piping X 

I didn't do it on purpose to lock up my system and risk FS corruption
durin unclean reboot. I was interested in the server output and " 2>&1 | less"
is the logical way to do that.

I could also "solve" this problem by not running linux. And I can "solve" all
gcc bugs by not using gcc. Those are not solutions. Not to me at least.

> output into interactive programs. tail -f is a viable workaround -- and 

tail -f ? what is the difference between :
$ X 2>&1 | tail -f
and
$ X 
?

> all this is off-topic on linux-kernel,

non-root user locked up the console code. console code is part of kernel.
it is a kernel topic.

> it's your own dumbness that makes 
> you do these things. Better run kdm, gdm or xdm or something and you're 
> not having this problem.

My own dumbness ? Did you also say that ping-of-death is not a problem ?
After all it is just the dumbness of people who send out broken ping packets,
no ? And if a computer crashes , businesses lose time and money, you pop up and
explain "no it is not really lost money/time, because it was caused by dumbness !".

-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
