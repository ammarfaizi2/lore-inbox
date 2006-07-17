Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWGQLsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWGQLsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 07:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWGQLsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 07:48:13 -0400
Received: from alpha.polcom.net ([83.143.162.52]:13541 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1750758AbWGQLsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 07:48:12 -0400
Date: Mon, 17 Jul 2006 13:48:02 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Caleb Gray <caleb@calebgray.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
In-Reply-To: <1153128374.3062.10.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net>
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

On Mon, 17 Jul 2006, Arjan van de Ven wrote:
> On Sun, 2006-07-16 at 20:02 -0700, Caleb Gray wrote:
>> Dear Linux Kernel Developers,
>>
>> I would like to express my experiences with the reiser4 filesystem and
>> my reasons for its readiness to be officially included in the Linux kernel.
>
> Hi,
>
> may I ask why you are sending this? Have you done code audits to the
> code? Have you done anything that was on the "these need fixing before
> it can go in" list?

Well, as I understand he is end user (an advanced one). He does his job as 
a end user: he does testing and reports back the results. This is not that 
common, as many users do not report problems / requests they have.

He even did more: he tested (very hard and extensively) experimental, not 
even in the tree part of the kernel. And he reported problems / ideas he 
found in a very kind and gentle way. This is not so common and makes him a 
valuable person in the users comunity in my opinion.

As I understand you, as a developer, should say "thank you" to him and 
make everything you can to solve the problems he has and help implement 
the parts of the software he needs. No?

That way you build comunity of users that not only are using the software 
but also are giving back in form of bug reports, feature requests, 
continuous testing on variety of setups (that no developer ever can have 
all), reviews, ideas, telling others about what a great software with 
friendly comunity they found and so on.

For me (I am active end user of most open source projects and developer 
on others) the comunity and good contacs between developers and end users 
is the most important part of the software. It gives me security. Even if 
the software is not yet stable it can be fixed by cooperation between 
users and developers. While people are really way harder to fix than 
software.

And he as a end user does not have to (and probably does not even have 
enough knowledge about the kernel internals) make code audits and 
review of new filesystem. So why are you demanding that he does one?


> If not, aren't you just doing campaigning on
> non-technical grounds? And isn't that a bad idea?

Well, his kind message was not very technical. But wasn't completly non 
technical or flamewar either. He tested software, compared and reported 
what he saw. He also expressed wish (that many users have) that Reiser4,
as a usefull and even useable in some production evironments, should be 
integrated into the kernel. Because there are users for it.


> Arjan van de Ven -- who is starting to smell a directed PR campaign
> leading to allergic reactions

Come on. Another conspiracy theory? Why some people just can't understand 
that Reiser4 is not that bad (from end user's point of view)? Some people 
tested it and found it good and want to have it integrated ASAP. Some even 
can't live without it after they used it for a while and saw how good it 
is in something...

I can assure you that it really is not some directed centrally controlled 
campaign. This is just what many users want.

I too tested Reiser4 some time ago. It didn't have any big problems for 
me. But I am not using (or testing) it now. Why? Mainly because of 
security: if Reiser4 is not merged (even as a experminental, subject to 
change, unstable, whatever) it will work with new kernels as long as 
Namesys will release patches. And if something happens to Namesys I will 
have to port it to new kernels (and that is usually trivial for kernel 
developers introducing incompatible internal kernel API changes but not 
for me) myself or will have to use old kernels. And _that_ is a problem 
for me.

(Not to mention that I am regulary applying 4-7 patches, some big ones, 
for every kernel I am building and resolving merge problems in not your 
code is not easy thing to do and takes time. While I can live without 
staircase scheduler or vesafb-tng if my manual merge attempt fails I can 
not do so without my main filesystem. And -mm is a little too unstable for 
me recently.)

It is unfortunate that Hans Reiser pushed Reiser4 the way he did and that 
he got the reaction from some kernel developers he did got. But he and his 
developers did (and are still doing) very hard job to fix problems and 
make Reiser4 better and more suitable into the kernel. And having Reiser4 
out of the kernel is hurting mainly end users. Really.

Arjan, is this really technically impossible to have Reiser4 merged into 
the kernel after fixing some worst problems that touch mm and VFS (in say 
2 months), flagged unofficial-try-merge-for-testing, super-experimental 
and subject-to-change? I would make live of many end users easier and does 
not sound that bad for me especially in the 2.6 forever era...

If someone thinks that Reiser4 is too unstable or evil he can set it to N 
and be happy. And if Reiser4 will be abandoned by Namesys and not fixed 
further it could be maintained by kernel developers at a minimal level 
(porting to new kernel internal APIs as they change) for say 6-12 months 
while flagged for removal and then removed because of 
unofficial-try-merge-for-testing flag. This at least does give some time 
to migrate from it for end users (and maybe even time to fix it for some 
other developers?).


Thanks and sorry for such long post,
wrong as usual,

Grzegorz Kulewski

