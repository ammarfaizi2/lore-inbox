Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTE3H6R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 03:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTE3H6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 03:58:17 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:22450 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263365AbTE3H6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 03:58:13 -0400
Message-ID: <20030530081226.13903.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: albert@users.sourceforge.net
Cc: rml@tech9.net, linux-kernel@vger.kernel.org
Date: Fri, 30 May 2003 16:12:26 +0800
Subject: Re: [announce] procps 2.0.13 with NPTL enhancements
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Well, since I read Albert Cahalan's comment in
>>> Debian bug #172735 [1] I understand the people
>>> maintaining a different branch...
>>
>> Exactly.
>>
>> That bug is fixed in the official tree, fyi.
>> A segfault, as you said, is always a bug.
>> An error message is displayed.
>
>You asked for it...
>
>Nice cheapshot there. So, if I remove some
>critical kernel interfaces from your system,
>nothing should crash? How about I take out
>a few choice system calls or a chunk of libc?

It is not the same thing, I think that you
agree on that, too.

>(note: the "bug" is not exploitable)
>
>Face it. For nearly a decade, /proc has been
>a critical kernel interface. This isn't 1991.
>(embedded systems excepted; they don't use procps)
>
>That said, I may do something about the issue
>simply to please users with messed-up systems.

In my opinion, you have to do something about
the issue, because it is a bug, it is not
a missing feature. But this is just my opinion,
you are the maintainer, you take decisions.

>> Once that bug is fixed, he will probably find
>> that the inability to read files in /proc also
>> causes a crash. Such is the problem with this
>> duplicated effort. It sucks.
>
>I could tell you about some inputs that
>make your programs crash... Nah. Find them
>yourself. I wait for your screams. >:-)

'Find them yourself', nice answer ;-(
It is a pity read this kind of comment,
I still don't understand the reasons 
of this duplications of code and the reason
of this kind of silly sarcastic remarks.

>You finally fixed a SEGV that I fixed well
>over a year ago. Congradulations. You have
>others to fix, and a minor (?) security
>issue as well. Have fun.

Again, you know there is a problem but you
don't say anything about it.
You do not want to fix it, don't you ?
This is fine with me (even if it is hard to 
understand the reason), but you are just
/wrong/ when you know about a problem and
don't provide information about it.
Again, this is just my opinion...

>Oooh... I think you have an exploitable
>buffer overflow as well. Anybody running
>his procps as an i386 binary on IA-64?

Ditto.

Ciao,
          Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
