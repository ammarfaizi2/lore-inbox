Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291918AbSBATFv>; Fri, 1 Feb 2002 14:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291919AbSBATFb>; Fri, 1 Feb 2002 14:05:31 -0500
Received: from [196.30.226.170] ([196.30.226.170]:31902 "EHLO www.ezinto.co.za")
	by vger.kernel.org with ESMTP id <S291917AbSBATFZ>;
	Fri, 1 Feb 2002 14:05:25 -0500
Date: Fri, 1 Feb 2002 21:11:46 +0200
From: Craig Schlenter <craig.schlenter@freemail.absa.co.za>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lkml] Re: A modest proposal -- We need a patch penguin
Message-ID: <20020201211146.A2574@codefountain.com>
In-Reply-To: <200201302239.QAA39272@tomcat.admin.navo.hpc.mil> <20020131032832.KJVO14927.femail22.sdc1.sfba.home.com@there> <20020130224112.A25977@havoc.gtf.org> <9cfy9iefvbt.fsf@rogue.ncsl.nist.gov> <a3d979$22g$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a3d979$22g$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Feb 01, 2002 at 05:31:21AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 05:31:21AM +0000, Linus Torvalds wrote:
[snip]
> Anyway, I'm actually personally willing to make small trials, and right
> now I'm trying to see if it makes any difference if I try to use BK [snip]

Are there any other cute pieces of technology that might be able to
help? I'm thinking specifically about a couple of scripts, bits of
procmail and changes to pine perhaps (or whatever mailer you use) so
that email/patch management becomes a bit easier.

The rationale behind most of the ideas below is to get better feedback
to people that email you with the same number of keystrokes as it would
have taken to simply delete the mail/thread and to better organise the
mail you get. I see you're already reading l-k through a newsreader ...

Some ideas:

- a 'patch-tester' that tries to auto-apply patches to a test tree and
if the application fails, flags the message in some way before popping
it in your mailbox eg. [SUCCESSFUL-PATCH] or [FAILED-PATCH] with the
failure as a text attachment to glance at in case you do want to try
to apply it.

- some procmail goo to dump patches that aren't sent as text attachments
or whatever, with a cute autoresponse to the sender giving details
of proper patch submission procedure.

- threads that are deleted or procmailed will trigger an autoresponse to
the sender if your name is in the TO or CC fields ( or the subject
contains [PATCH] ) saying you've nuked the thread and if they really
want a response from you it should be sent under a different name and
provide a pointer to a 'submitting patches to Linus' page. Perhaps
there could be two types nuking emails: 'nuked since I've got 50 million
emails in my inbox' and 'thread is uninteresting, nuked on
[DATE] while reading [MSGID]' ...

- some hotkeys to autoreply to things with canned responses ...  I am
reminded of the 'tick a box' sort of email things but that can be
driven with 1 or 2 keypresses to reply and send the right response:
[ ] You have sent me a patch that does not apply cleanly
[x] Read the codingstyle doc!!! This is awful. Not applied
[ ] This doesn't even compile. Not applied.
[ ] Applied. Thank you.
[ ] Resend diff against latest pre-patch please.
[ ] Resend via the relevant maintainer [link to list] please.
[ ] I can't accept your marriage proposal. I'm already married.
[ ] Send money to [BANK DETAILS]
[ ] Yes
[ ] Never!
etc. ... Some of these might be triggered automatically perhaps eg.
based on the code that a patch touches, the sender etc.

Anyway, just ideas ... there must be something that will make life a
little easier if it was automated and there are probably lots of people
wanting to put a 'I wrote a script that Linus uses' stamp on their CV so
you wouldn't even have to code the stuff yourself :)

Cheers,

--Craig
