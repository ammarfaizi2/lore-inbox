Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSE0MhM>; Mon, 27 May 2002 08:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSE0MhL>; Mon, 27 May 2002 08:37:11 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:43469 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316595AbSE0MhJ>; Mon, 27 May 2002 08:37:09 -0400
To: Paratimer@aol.com
Cc: rddunlap@osdl.org, lm@bitmover.com, erwin@muffin.org, yodaiken@fsmlabs.com,
        linux-kernel@vger.kernel.org, rtai@rtai.org
Subject: Re: RTAI/RtLinux 
From: Wolfgang Denk <wd@denx.de>
X-Mailer: exmh version 2.2
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: Your message of "Mon, 27 May 2002 08:10:49 EDT."
             <57.c083d0f.2a237c49@aol.com> 
Date: Mon, 27 May 2002 14:36:38 +0200
Message-Id: <20020527123643.9297A11973@denx.denx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <57.c083d0f.2a237c49@aol.com> Joachim Martillo wrote:
> 
> Hardly seems surprising.  Linux is a general purpose multiuser
> moderate weight multiprocessing preemptive time sliced time 
> shared virtual memory operating system.  Embedded system
> developers generally need single purpose extremely lightweight
> limited process count nonpreemptive cooperative real memory
> operating systems.  

Joachim, your perception of "Embedded Systems" is  not  up  to  date.
There  is  a  lot  of devices which fall into this group that provide
resources you have been dreaming of for your workstation just 5 years
ago. For instance, your digital video recorder may have  a  200+  MHz
PowerPC  CPU,  tens  of  megabytes RAM and tens of gigabytes harddisk
space. Can you remember the configuration of your fastest workstation
from 10 or 5 years ago?

Yes, there are embedded systems with limited resources where Linux is
just overkill. And probably (by number of units sold)  these  devices
are the majority.

But there are also lots of embedded devices that not only provide the
resources for a more powerful OS  like  Linux,  but  also  demand  it
because  of  the  complexity of applications they are running. And if
you look at current trends you will find that  this  is  one  of  the
fastest growing parts on the market.

> There is not so much overlap between the two types of
> operating systems.  It is to the credit of the Linux design
> that with hacking Linux can generally be adapter to real
> time uses unlike some other common proprietary operating
> systems.

Again, this is not quite  correct.  There  have  been  Real-Time  and
Embedded  Unix  systems  before  (LynxOS, to name one). And there are
other "common proprietary operating systems" that can be adapted  for
embedded needs (WinCE).

The big advantages of Linux are in  defferent  areas  (free  sources,
excellent  support  of  all  modern technologies, not single-sourced,
...).


The problems with Linux  in  Embedded  and  especially  in  Real-Time
Systems  are not technical ones. It is the political situation, where
the user is left in uncertainty about what he can legally do and what
not.

And if you look at the (missing) answers to  all  specific  questions
about  this  you  can  see  that there is method to it. "Go and see a
lawyer" is all you get.

Hell, would you do busines with ANY company who tell  you  "ask  your
laywer"  when  you  ask  for explanations of the conditions of use of
their products?

THIS is the main problem of Linux in the real-time market.


But who knows, maybe VY will provide clear "yes" / "no" answers  this
time...

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Man did not weave the web of life; he  is  merely  a  strand  in  it.
Whatever he does to the web, he does to himself.     - Seattle [1854]
