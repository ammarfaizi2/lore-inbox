Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKHMRQ>; Wed, 8 Nov 2000 07:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129255AbQKHMRH>; Wed, 8 Nov 2000 07:17:07 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:14862 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129091AbQKHMQ7>; Wed, 8 Nov 2000 07:16:59 -0500
Date: Wed, 8 Nov 2000 12:15:48 GMT
Message-Id: <200011081215.MAA69418@tepid.osl.fast.no>
Subject: Re: [RANT] Linux-IrDA status
X-Mailer: Pygmy (v0.4.4pre)
Subject: Re: [RANT] Linux-IrDA status
In-Reply-To: %s: <Pine.LNX.4.10.10011072316180.15590-100000@penguin.transmeta.com>
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I agree that the latest patch wasn't good about specifying its contents. 
But in fact, the 26th of august I sent you a mail which was much better
(but then your mailbox crashed or something!?) Since you hadn't applied 
any previoius patches (and not even the  patches from Russell), I felt that you
wasn't to interested about IrDA (even if Transmeta is a member of IrDA these 
days ;-) or didn't have time to look thru them. So that's the reason for the 
very short description. I'm sorry about that!

I've watched the ISDN discussion a year ago, so I already knew what you
felt about such large patches. The truth is that I've been very busy with my 
new job, and haven't had much time to maintain the Linux-IrDA project, so 
those large patches was the best I could do, and it's correct that I haven't  
actually flooded you with patches the last 6 months.

But we should anyway discuss what to do with IrDA support in Linux 2.4. 
The state of the current IrDA code in 2.4 is very bad and probably not 
working at all. The latest patch may have some bad code as well but at 
least things are working (and Linux isn't the OS which is best known for it's
beautiful code anyway). It will eventually be fixed, once people start 
complaining!

Some options:

1) Split up the large patch and fix the things you didn't like, submit them
with better discription. But then It's probably to late anyway for 2.4 (even if 
the 2.4-test series is not the most stable stuff I've tried). Is it to late for this?

2) Remove IrDA from the kernel, and we'll go back to using CVS and 
make our own package (like PCMCIA and IrDA was before they got 
into the kernel. At least PCMCIA used to work back then ;-)

3) Just apply the stuff!?! Look at Jean's mail for description of the changes.

-- Dag

On Tue, 7 Nov 2000 23:26:34 -0800 (PST), you wrote:
> 
> 
> On Wed, 8 Nov 2000, Michael Rothwell wrote:
> > 
> > Like what? I'm not sure what you're saying here. It seems that the pople
> > writing the IrDA code have gotten no feedback from you as to why their
> > patch is never accepted -- could you clarify?
> 
> Just to clarify.
> 
> The ONLY message from the IrDA people I've gotten during the last few
> weeks has been a SINGLE email from Dag Brattli, with a 330kB patch.
> 
> The whole, full, unabridged explanation for those 330kB of patches:
> 
> >> Hello Linus,
> >> 
> >> Here is the latest IrDA patch for Linux-2.4.0-test10. 
> >> 
> >> Short summary: 
> >> 
> >> o Fixes IrDA in 2.4
> >> o Touches _no_ other files. 
> >> 
> >> Please apply! 
> >> 
> >> Best regards
> >> 
> >> Dag Brattli
> 
> That's it.
> 
> ONE message during the last month. ONE huge patch. From people who should
> have known about 2.4.x being pending for some time. 
> 
> 10,000+ lines of diff, with _no_ effort to split it up, or explain it with
> anything but
> 
> 	"o Fixes IrDA in 2.4"
> 
> and these people expect me to reply, sending long explanations of why I
> don't like them? After they did nothing of the sort for the code they
> claim should have been applied? Nada.
> 
> Get a grip. 
> 
> 		Linus
> 
> 
> 
----
Dag Brattli,                       Mail:  dagb@fast.no
Senior Systems Engineer            Web:   http://www.fast.no/
Fast Search & Transfer ASA         Phone: +47 776 96 688
P.O. Box 1126                      Fax:   +47 776 96 689
NO-9261 Tromsø, NORWAY             Cell:  +47 924 05 388

Try FAST Search: http://www.alltheweb.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
