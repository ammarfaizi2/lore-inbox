Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTLVCzX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 21:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTLVCzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 21:55:23 -0500
Received: from opersys.com ([64.40.108.71]:45580 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S264289AbTLVCzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 21:55:13 -0500
Message-ID: <3FE65DB9.9080605@opersys.com>
Date: Sun, 21 Dec 2003 21:58:01 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: yodaiken@fsmlabs.com, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updating real-time and nanokernel maintainersy
References: <3FE234E4.8020500@opersys.com> <Pine.LNX.4.58.0312181821270.19491@montezuma.fsmlabs.com> <3FE23966.7060001@opersys.com> <Pine.LNX.4.58.0312181836360.19491@montezuma.fsmlabs.com> <3FE23CD1.4080802@opersys.com> <3FE23E3F.2000801@cyberone.com.au> <3FE2424B.70901@opersys.com> <20031219094122.GA23469@wohnheim.fh-wedel.de> <20031221082736.GA11795@hq.fsmlabs.com> <3FE5F2E6.8030002@opersys.com> <Pine.LNX.4.58.0312211145490.13039@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312211145490.13039@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
>>If there is, then it should definitely be taken out. First, as Linus
>>has stated recently (and as has been the policy for a while), the
>>kernel should avoid having any patented code
> 
> That's not true.
> 
> The kernel should have no patented code THAT DOESN'T HAVE A LICENSE.

You're right, I didn't use the _exact_ same wording, but you seem to be
seeing an intent to deceive where there was none.

> The email you quote expressly says "unless you can get the patent holder 
> to grant a license". And the RTLinux patents were licensed to GPL'd 
> projects. See the RTLinux "open patent license".

As in May 2002, you're still reading the license but ignoring the FUD
spread by the patent holder.

But all that RTLinux patent business is really beside the point (and has
been for quite some time.) The point is that the RTLinux patent is a
non-issue at this stage because I basically applied the other thing you
were suggesting in that above-mentioned email: "find an unencumbered
algorithm." The Adeos nanokernel is such an algorithm and, if I read you
correctly, should therefore be preferable to one which is patented and
somehow licensed for use by GPL software.

> I don't understand why people continually complain about the RTLinux
> patents. I bet it's because Victor has all the easy charm of Larry McVoy,
> but I don't see why people still continue to spread obvious
> mis-information about the situation.

Well, I have to dare ask: Do you really understand the situation?

Fact is, I don't personally care about the RTLinux patent anymore, and
neither do any of the folks who had taken part in the May 2002 debate
on the topic. Why? Because we've implemented a nanokernel that can
provide deterministic response times based entirely on scientific
publications that pre-date the preliminary patent filling by more than
one year, and which is therefore not subject to the patent.

I've personally written a book on the topic of building embedded Linux
systems, and have been in constant contact with people building such
systems for quite a few years. I may not know everything, but my knowledge,
limited as it may be, tells me that Linux has a serious problem in regards to
its use in real-time applications because of continued FUD coming from
statements such as those made by Victor in the interview I'm referring to
in my earlier email.

Technically, though, (and this is really the most important point I have
to make in this email):
THE RTLINUX PATENT IS __NOT__ AN ISSUE ANYMORE BECAUSE OF THE ADEOS NANOKERNEL.

So my question to you is this: Do you prefer continue supporting those who
are holding a patent against Linux or those who have found a way to obtain
the same results using a method which is unencumbered by patents?

My patch for replacing the RTLinux entry wasn't a complaint about the
RTLinux patent, it's just a reflection of the de-facto situation regarding
Linux's use in real-time applications.

> It's doubly discgusting with some of the people who were trying to spread 
> all the FUD and mis-information were doing so because they were themselves 
> doing a non-GPL microkernel, and they complained about how the patents 
> were somehow against the GPL and wanted to get community support by trying 
> to make out the situation to be somehow different from what it was.

Non-GPL microkernel? Sorry, I don't know anything about that.

What I, and everyone involved in this, did ask for (and you can read the
original in my initial response to you in the May 2002 thread here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102228176631331&w=2) is for
non-GPL _applications_. And I continue to maintain that the FUD spread by
statements such as those made by Victor in his latest interview about the
fact that hard-real-time applications are somehow encumbered by a patent is
hurting Linux.

As for the alleged FUD you seem to think the likes of me are spreading, then
care to read Victor's latest interview? Here's Victor quoting "a guy from
one of the huge telecommunications equipment companies": "We are very aware
of the RTLinux technology, but your patent makes things awkward for us."

Does this or does this not hurt Linux?

> I'm not a supporter of software patents, but while I dislike them, I don't 
> dislike them _nearly_ as much as I dislike dishonest people.

It's not unheard of for people in a position of influence to blunder. I
think you are mistaken here, and will not entertain a tit-for-tat response
to your ad-hominem attacks. You seem to be unaware of the issues and/or
refuse to seek further understanding. That is your choice, and if nothing
else, you are consistent in not wanting to revisit your stance on RTLinux.
The bottom line is that it's your own OS that is suffering. I'm certainly
in no position to impose it upon you to help your own self, and I certainly
can't help you if you don't want to be helped, but I will continue my
efforts to further Linux's use in the real-time field because I believe
this is a worthy goal.

Best regards,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

