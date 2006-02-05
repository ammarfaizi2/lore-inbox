Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWBEE3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWBEE3L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 23:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWBEE3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 23:29:11 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:25578 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S932596AbWBEE3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 23:29:10 -0500
Message-ID: <43E57B9E.2050504@gmail.com>
Date: Sun, 05 Feb 2006 08:14:22 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-dvb@linuxtv.org
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-dvb] patch collection for Kernel 2.6.16-rc1
References: <2183.1138984776@www072.gmx.net>	<20060204193542.GB6985@linuxtv.org>	<200602050010.37293@orion.escape-edv.de> <20060204232031.GF4528@stusta.de>
In-Reply-To: <20060204232031.GF4528@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian Bunk wrote:
>
> Andrew includes many patches into -mm, but usually doesn't forward them 
> to Linus without maintainer approval. Instead, he forwards non-approved 
> patches to the maintainers of the code being changed.
>
> This helps in reducing the number of patches being lost.
>
> Therefore, it's not unusual that Andrew accepted a patch by Uwe, but I 
> was very surprised if Andrew had forwarded such a patch to Linus without 
> maintainer approval.
>
>   

It did happen. (in 2.6.13-mm2) I have put the documents up here so that 
the differences can be seen

http://www.thadathil.net/dvb-doc-regression/

doc_current/ --> contains the latest changes, that i made. This was 
necessary, since the dst module went through some design changes.
doc_original/ --> was the original document in CVS
doc_uwe_patched/ --> was the document changed by Uwe, which caused the 
regression.


I did not want to make the private mails public, but since this topic 
has gone so far, than what it should have been to *insult* the people 
around it, it would be the best that i forward the copy of the mail that 
was sent privately. People, do amuse yourselves with the mails. This is 
what you get if you help other people. I can say for sure that this is 
not an isolated case. Copy of mail to LKML, since a patch was sent to 
AKPM on this aspect. CC to akpm fails in a while and hence.

Even with a lot of insults, Johannes accepted that it was his mistake ( 
for no reason i don't understand why ). I still don't know when the DVB 
developers were on the move (this wasn't the convergence to linuxtv.org 
transition though, since that transition was not during the period of 
the said patch), as was said in the mail, but rather the period when 
Gerd was quitting as v4l maintainer. I don't see any relation between 
these though.

Hope this clears the confusion. I hope this thread dies soon, rather 
than wasting a lot of precious time which could otherwise be used for 
real developmental issues. (I make a request to Uwe, in this regard to 
stop this thread, and not to make such insults in the future, as it is 
very very destructive. PLEASE, A HUMBLE REQUEST.... !)


Regards,
Manu



-------- Original Message --------
Subject: 	kernel patch practice in 2.6.13-mm2
Date: 	Tue, 13 Sep 2005 16:46:35 +0200 (MEST)
From: 	Uwe Bugla <uwe.bugla@gmx.de>
To: 	manu@linuxtv.org
CC: 	js@linuxtv.org



Hi,
if you continue to send or sign mm-patches for Kernel 2.6.13 as a
consequence of a design change I would appreciate you to stop rubbing out my
name.
You did that in a file called /Documentation/dvb/bt8xx.txt.
My objective is understandable good documentation, even if it may sound
trivial for some developpers minds. I always have in mind that there are
also lots of beginners reading those documents.
As I respect your work I never in my life would even dare to rub out other
coauthors names.
That´s why I appreciate you to respect my name and stop rubbing it out.

Thanks
Uwe Bugla

P. S.: If you f. ex. publish a book I ain´t gonna burn it as a matter of
disrespect. So have a little respect vice versa!

-- 
Lust, ein paar Euro nebenbei zu verdienen? Ohne Kosten, ohne Risiko!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner





-------- Original Message --------
Subject: 	"synchronization problems"
Date: 	Thu, 15 Sep 2005 10:44:38 +0200 (MEST)
From: 	Uwe Bugla <uwe.bugla@gmx.de>
To: 	js@linuxtv.org
CC: 	manu@linuxtv.org



Hallo Mr. Stezenbach,

"You breached the protocol by not sending the patches to the maintainer
or linux-dvb list. The result of this was that we had conflicting
changes in CVS. I spent about 10 minutes thinking how I could
merge the two, and then gave up (I had 53 other patches to prepare
and I had little time left to do the job). So I didn't just remove
your name, but all changes which you sent to akpm along with it.
bt8xx.txt in the kernel is now in sync with the version in linuxtv.org CVS."

I didn't breach any protocol, nor did I break any unwritten rule or law. I
simply took the advice from Gerd Knorr that linuxtv maintainers were just
moving to another place to the point of time when I sent in my first
dvb-bt8xx-patch. So consequently I took the direct way to send it to akpm.
Just to be sure it is really being applied without waiting 3, 4 weeks or
however long. So if you continue to at least discussing with my person,
please immediately stop doing that in such a bureaucratic manner. If
synchronization of CVS and kernel.org only works unidirectional, and not
bidirectional, then neither I, nor akpm, nor Manu or anybody else has a real
problem, but you personally have one without any doubts.
And if you lack time, simply delegate your job to another person. But simply
stop rubbing out other peoples coauthorship and pay respect to their
contributions. And the biggest joke about your personal misbehaviour is the
fact that you personally cosigned at least one of my patch attempts, without
dropping me a single note asking me to not bypass the linuxtv CVS
maintainers. So good morning Mr. Stezenbach, I appreciate you to wake up a
little bit earlier in the future!

"Additionally you deleted information from bt8xx.txt which I think were
useful help for debugging problems, and which were written there on purpose
by the developer. So if you talk about respect, you could show some yourself
by not bypassing the original authors and maintainers when sending patches."

In fact I did, and I can tell you the simple reasons why.
There are in fact two things that I simply cannot and will not tolerate:
a. orthographic junk (examples: "bythe" or, even worse: "autodected" and
"Recognise") It was ME who corrected that in the past, and it was YOU
personally who reversed that, if not to say: fucked it up in the current
2.6.14-rc1. So as a consequence it is YOUR task to do your homework and
apologize for that, but not MINE!
b. attempts of documentation that do NOT correspond to their appropriate
kernel design
What do I mean with b.?
1. In Kernels 2.6.12 AND 2.6.13 the simple command "modprobe dvb-bt8xx"
caused ALL OTHER modules to load automatically:
cx24110, dst, dst-ci and dst-ca. Now if the kernel design forces the
automatic loading of dst, dst-ca and dst-ci, every attempt of discussion
about debug parameters is simply obsolete! So if I cannot load the dst
module separately, how should I be able to hack in
debug parameters? I know what debug parameters are for, and I deeply respect
developers work, but what the hell is it all worth for if a kernel design
suppresses hacking in debug parameters?
2. Moreover I am not shure in how far the parameters 0x68 and 0x71 really
correspond to TwinHan cards. A closer look to CARDLIST.bttv says: card ID =
113. But perhaps I have problems to deal with hexadecimal numbers, and this
would simply be my problem, not yours!

4 rules for a real good documentation:
1. understandable and transparent information for different understanding
levels
2. strictly corresponding to the laws of the current kernel design
3. absolutely errorfree concerning orthographic junk
4. structured in a senseful manner (f. ex.: headliner corresponds to real
contents)

If an attempt of documentation lacks at least one of the four, it is simply
useless to my opinion. Why aren't debug parameters part of another part of
documentation, f. ex. ci.txt? Or ca.txt? The headline of dvb-bt8xx.txt goes:
"How to get the Nebula, PCTV, and TwinHan DST cards working."
My question: If the essence of a documentation text is how to bring up a
specified card, then please what the hell has that got to do with debug
parameters? Who are the addressed groups of such a text? To my opinion at
least the headliner says that the following text addresses users and nobody
else!
So I simply never intended to bypass any developer, but I simply found out
that the bt8xx-documentation simply did not correspond to the actual kernel
design. In other words: Was unusable. So I decided to write a patch and
simply act instead of performing endless discussions, and that's all about
it!
And: If you reinvent the name of cards: Do it for whatever reason, for god's
sake! But: How the hell do you define to a person not convenient with all
that special technical vocabulary, what the hell a BT8xx-card is? Remember
the first of my 4 rules (see above!). So at least a complete list of cards
conforming to that standard is necessary for transparent information:
Question: Pinnacle PCTV SAT, Nebula Electronics DigiTV, TwinHan DST and
clones, Avermedia of all kinds..... Is that list complete? If not, please
drop me a note where I can get that complete list of cards corresponding to
that standard, and I'll instantly sit down and write a patch to improve
documentation.
But before I even think about doing that I appreciate you to do your
homework:
a. readd my name (I didn't delete it, so I won't do the same job again, not
for sync reasons, and not for reasons of lack of time, and not for any other
reason.
b. fix orthographic errors in dvb-bt8xx.txt (for the same reason mentioned
in point a.)
c. reconstruct my 2.6.13-structure of dvb-bt8xx.txt as far as possible
d. reflect very well, whether debug parameters should not better be situated
in different documentation texts (logically structured, understandable)

Regards

Uwe Bugla

P. S.: akpm never complains about lack of time, and he is doing a very fair
and good job, and, at least for him, the amount of 54 patches is simply
peanuts. I love cooperation with guys like him!
In other words: I respect the demand that cvs-tree and current kernel must
be in sync somehow, but if the output is rubbish for several reasons and,
moreover, neglects my work, there is simply no reason for any kind of
respect. Because I ain't no idiot, just to say it in very simple words.
So please in future avoid to blame my person for things that you personally
don't get worked (synchronization or whatever kind).
And would you please answer me one question: How can I be shure that my
patchwork at least enters the institution akpm, if there is someone like you
in between complaining for lack of time and synchronization faults? I prefer
flat hierarchies (the real hidden success principle of Linux) and
cooperation with akpm works very fine.
So, as a matter of principle, I don't see any reason why I should prepare
and send in my work three, four, five times, just because at the other end
someone doesn't get his stuff synchronized or lacks time. I ain't no idiot!
Ya Basta!
And even if I would give in now for strategic reasons and do the same
fuckin' work again, how many Stezenbach clones or whoever would come up
afterwards and continue to fuck up my work in the same or just in a
different way you personally did? Who do you think you are and who do you
think I am? So please do your homework, and do it correct in the future, or
leave that job simply to another person. OK?
Any further questions, Mr. Johannes Stezenbach?

-- 
Lust, ein paar Euro nebenbei zu verdienen? Ohne Kosten, ohne Risiko!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner






