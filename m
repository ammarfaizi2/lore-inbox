Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264791AbRFXV5k>; Sun, 24 Jun 2001 17:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbRFXV5b>; Sun, 24 Jun 2001 17:57:31 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:28828 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264794AbRFXV5T>; Sun, 24 Jun 2001 17:57:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "J . A . Magallon" <jamagallon@able.es>, landley@webofficenow.com
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Sun, 24 Jun 2001 12:55:59 -0400
X-Mailer: KMail [version 1.2]
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz> <0106220929490F.00692@localhost.localdomain> <20010624234101.A1619@werewolf.able.es>
In-Reply-To: <20010624234101.A1619@werewolf.able.es>
MIME-Version: 1.0
Message-Id: <01062412555901.03436@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 June 2001 17:41, J . A . Magallon wrote:
> On 20010622 Rob Landley wrote:
> >I still consider the difference between threads and processes with shared
> >resources (memory, fds, etc) to be largely semantic.
>
> They should not be the same. Processes are processes, and threads were
> designed for situations where processes are too heavy. Other thing is that
> in new kernels (for example, Linux) processes are being optimized (ie, vm
> fast 'cloning' via copy-on-write) or expanded with new features (Linux'
> clone+ CLONE_VM). But they are different beasts.

This is a bit like like saying that a truck and a train are totally different 
beasts.  If I'm trying to haul cargo from point A to point B, which is served 
by both, all I care about is how long it takes and how much it costs.

I don't care what it was INTENDED to do.  A rock makes a decent hammer.  So 
does a crescent wrench.  The question is how good a tool is it for the uses 
we're trying to put it to?

> This remembers on other question I read in this thread (I tried to answer
> then but I had broke balsa...). Somebody posted some benchmarks of linux
> fork()+exec() vs Solaris fork()+exec().

What programs does this make a difference in?  These are tools meant to be 
used.  What real-world usage causes them to differ?  If a reasonably 
competent programmer ported a program from one platform to another, is this 
the behavior they would expect to see (without a major rewrite of the code)?

> That is comparing apples and oranges.

Show me a real-world program that makes the distinction you're making.  
Something in actual use.

> The clean battle should be linux fork-exec vs vfork-exec in
> Solaris, because for in linux is really a vfork in solaris.

But the point of threading is it's a fork WITHOUT an exec.

So now you're saying the comparison we're making of "using these tools to do 
goal X" is invalid because you don't like goal X, and you want to do 
something else with them.

I'm not going to comment on the difference between fork and vfork becaue to 
be honest I've forgotten what the difference is.  Something to do with 
resource sharing but darned if I can remember it.  I'm not sure I've ever 
used vfork, last thing I remember were people arguing over the man page for 
it...

(Sorry  if I seem a bit snappish, I've had this kind of discussion too many 
times with ivory tower types at UT who object to the topic of conversation 
because it's not what they've focused on until now.  Which logical fallacy 
was this, "begging the question"?  Straw man?  I forget.  I'm tired...)

Rob

