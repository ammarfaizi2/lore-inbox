Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280503AbRJaUxk>; Wed, 31 Oct 2001 15:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280501AbRJaUxb>; Wed, 31 Oct 2001 15:53:31 -0500
Received: from web20405.mail.yahoo.com ([216.136.226.124]:62225 "HELO
	web20405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280503AbRJaUxY>; Wed, 31 Oct 2001 15:53:24 -0500
Message-ID: <20011031205401.80286.qmail@web20405.mail.yahoo.com>
Date: Wed, 31 Oct 2001 12:54:01 -0800 (PST)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Digest message 28, subject: 2.4.14-pre6
To: linux-kernel@vger.kernel.org
In-Reply-To: <200110311858.f9VIw2E07379@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone,

--- linux-kernel-digest-request@lists.us.dell.com wrote:
> Today's Topics:
>
>   28. Re: 2.4.14-pre6 (Linus Torvalds)
>
>--__--__--
>
> Message: 28
> Date:   Wed, 31 Oct 2001 11:38:44 -0800 (PST)
> From: Linus Torvalds <torvalds@transmeta.com>
> To: Michael Peddemors <michael@wizard.ca>
> CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: 2.4.14-pre6
>
>
> On 31 Oct 2001, Michael Peddemors wrote:
>
>> Lets' let this testing cycle go a little longer before making any
>> changes.. Let developers catch up..
>
> My not-so-cunning plan is actually to try to figure out the big problems
> now, then release a reasonable 2.4.14, and then just stop for a while,
> refusing to take new features.
>
> Then, 2.4.15 would be the point where I start 2.5.x, and where Alan gets
> to do whatever he wants to do with 2.4.x. Including, of course, just
> reverting all my and Andrea's VM changes ;)
>
> I'm personally convinced that my tree does the right thing VM-wise, but
> Alan _will_ be the maintainer, and I'm not going to butt in on his
> decisions. The last thing I want to be is a micromanaging pointy-haired
> boss.

	Let me speak out now and say that IM3VHO opinion, Alan
should keep the Linus VM alive in the 2.4 series, and he should also
maintain 2.4-ac with Rik's VM. IM3VHO, both VMs are good at different
things; thus, both of them should be hung onto, and maintained until
a general vote of either Linux's users or the top kernel maintainers
for either VM. The same goes for other differences between virgin
Linus and -ac.

>
> (2.5.x will obviously use the new VM regardless, and I actually believe
> that the new VM simply is better. I think that Alan will see the light
> eventually, but at the same time I clearly admit that Alan was right on a
> stability front for the last month or two ;)

	Quick note: Andrea's VM and Linus's kernel have been a very good
combination. My 900MHz Athlon box with 256MB RAM and about 100MB swap
ran very badly on 2.4.9. With 2.4.10 it runs much nicer (more responsive,
less swapping, actual paging, etc.)
	
>
>> My own kernel patches I had to stop because I couldn't keep up ....  Can
>> we go a full month with you just hitting us over the head with a bat
>> yelling 'test, dammit, test', until this is tested fully before
>> releasing another production release?
>
> I think we're really close.

	Really close? How close is really close? Can it be quantified?
	
>
> [ I'd actually like to thank Gary Sandine from laclinux.com who made the
>   "Ultimate Linux Box" for an article by Eric Raymond for Linux Journal.
>   They sent me one too, and the 2GB box made it easier to test some real
>   highmem loads. This has given me additional load environments to test,
>   and made me able to see some of the problems people reported.. ]
>
> But I do want to make a real 2.4.14, not just another "final" pre-kernel,
> and let that be the base for a reasonably orderly switch-over at 2.4.15
> (ie I'd still release 2.4.15, everything from then on is Alan).
>
>                Linus

Brad

P.S: You guys have done an absolutely wonderful job. Despite the occassional
flamewar holocaust, Linux 2.4 (in any form, -linus -ac -aa) is the best
Linux ever.

=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
Alternate e-mails: kakadu@adelphia.net
		   kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
