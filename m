Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUH0UKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUH0UKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267346AbUH0UJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:09:01 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:59397 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S267370AbUH0Ty6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:54:58 -0400
Message-Id: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.2.0
Date: Fri, 27 Aug 2004 21:54:55 +0200
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
From: Kenneth Lavrsen <kenneth@lavrsen.dk>
Subject: Re: Summarizing the PWC driver questions/answers
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:26 2004-08-27, you wrote:

>First off, here's Nemosoft's big post about the driver, please read that
>first, and the responses to that thread:
>http://thread.gmane.org/gmane.linux.usb.devel/26310

Reading the thread (which I already did) shows even more clearly that what 
you did is wrong.
The hook and the functionality of pwc/pwcx has been in the kernel for years.
People like myself have invested quite much money on cameras - assuming 
that no evil person would remove the support of an existing hardware from 
the Linux kernel once the support had been added.
What you did is WRONG. You may have the rights to do it. But it is WRONG. 
Once the support has been added it is wrong to remove it without replacing 
it with something else.

>And here's Linus's response after I removed the driver, when Nemosoft
>asked me to:
>http://thread.gmane.org/gmane.linux.kernel/229968

I wonder if Linus is aware of the entire story or he only heard your part 
of it.
And Linus. If you still support this.. I would very much like you to answer 
me - and the 10000s of other people that spent money on a piece of hardware 
that we had every reason to believe would continue to be supported by Linux 
- these questions.

- What is your excuse for forcing us to throw away worth 2000 dollars of 
cameras?
- How do you feel about the many others that are in the same situation?
- What is the next hardware or software - currently supported by Linux - 
that you will allow being made impossible to use for whatever fanatic 
reasons? (This is not exactly like the principles you stated in your book).
- Do you actually care about the many people that uses Linux?
- Do you actually care about people? If yes. Why do you allow this to happen?
- How will this behavour bring Linux to the desktops?


>Q: Why did you remove the hook from the pwc driver?
>A: It was there for the explicit purpose to support a binary only
>    module.  That goes against the kernel's documented procedures, so I
>    had to take it out.

You did not HAVE TO remove the hook. It had been there for years. You could 
have worked out an alternative way nice and quietly with the module developer.
If someone came with a new driver it was something else because no-one 
would be depending on it.

>Q: That hook had been in there for years!  Why did you suddenly decide
>    to remove it now?
>A: I was really not aware of the hook, and the fact that it was only
>    good for a binary module to use.  I'm sorry, I should have realized
>    this years ago, but I didn't.  Recently someone pointed this hook out
>    to me, and the fact that it really didn't belong in there due to the
>    kernel's policy of such hooks.  So, once I became aware of it, I had
>    no choice but to remove it.

Yes. Again. You had the choice to leave this one in UNTIL an alternative 
approach had been made. It was not at all necessary to do what you did. You 
were not forced to do it by anyone. It was your choice.

>Q: Why did you delete the whole pwc driver from the tree?
>A: That is what the original author (Nemosoft) wanted to happen.  It was
>    his request, and I honored it.  Go ask him why he wanted it out if
>    you are upset about this, I merely accepted his decision as he was
>    the current maintainer and author of the code.

You were probably happy because it has been clear for months that the two 
of you did not get along very well. And now we all have to suffer because 
of this.

>Q: You jerk, I had invested lots of money in this camera, you are
>    costing me money by ripping it out.  You should be ashamed of
>    yourself!
>A: See the above question about freedom.  If it means that much to you,
>    then offer to maintain the code, it's that simple.

So only people that can code kernel modules have rights in your world? You 
have no responsibility?

>Q: You are a fundamentalist turd / jerk / pompous ass /
>    GNU-freebeer-biased-idiot-fundamentalist fucktard / ignorant slut!
>A: I've been called worse by better people, get over yourself.

Maybe you should start listen to people.
Maybe they get angry at you for a good reason.

I am a typical icebreaker. I brought the first Linux box into Motorola in 
Copenhagen. It was an uphill battle against management. Against IT 
department managers. But after one year of pushing I was allowed to run a 
pilot project. Guess what. I am in doubt now. Will my Linux box still 
support my hardware and software a year from now.
Will I continue to push for getting more Linux boxes into our company? No. 
This is much more than just a camera thing. This is about commitment. Does 
the Linux and open source community commit to support the hardware and 
software to buy or invest money on developing? Or can a fanatic with ideas 
destroy everything. There are people that have built a business making cost 
effective surveillance systems with Linux and USB cameras using Motion. 
There will be no more support of their boxes anymore because of you. I 
wonder what names they give you now.

Kenneth


-- 
Kenneth Lavrsen,
Glostrup, Denmark
kenneth@lavrsen.dk
Home Page - http://www.lavrsen.dk  


