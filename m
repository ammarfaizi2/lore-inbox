Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWBHJq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWBHJq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWBHJq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:46:29 -0500
Received: from ns.firmix.at ([62.141.48.66]:10127 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932116AbWBHJq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:46:28 -0500
Subject: Re: Linux drivers management
From: Bernd Petrovitsch <bernd@firmix.at>
To: David Chow <davidchow@shaolinmicro.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <43E940BF.7020203@shaolinmicro.com>
References: <20060207044204.8908.qmail@science.horizon.com>
	 <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com>
	 <43E8F8EB.8010800@shaolinmicro.com> <20060207221513.GA7394@thunk.org>
	 <43E940BF.7020203@shaolinmicro.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 08 Feb 2006 10:46:02 +0100
Message-Id: <1139391962.14493.45.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 08:52 +0800, David Chow wrote:
[...]
> >(In some cases, end-users send hate mail to the Linux kernel
> >developers when some idiot company's binary driver modules is buggy
> >and corrupts the kernel in hard-to-debug ways; one particular video
> >driver company is especially guilty here, and is viewed by some as
> >being directly responsible for the tainted kernel flags.)
> >
> >The assumption by many developers is that if we concetrate on making
> >Linux as good as possible, it will eventually get popular enough that
> >hardware vendors will feel a commercial incentive to cooperate with
> >our way of doing things.  Obviously, this in practice things don't
> >always work that way --- the Sony Betamax is story is one where
> >technical excellence doesn't always win out.  However, at least in the

But only because the company behind BetaMax (and BetaMax was only second
best behind Philips Video2000 AFAIR) had not enough money and/or
motivation to stay long enough to make the technical better solution
also successful.
IOW you won't get the perspective right if you view from the commercial
old-ecenomy world only (as you do up to now!)

> >server space, compromising hasn't obviously been a bad strategy, with
> >many SCSI and FC controller manufacturers deciding on their own to
> >work with the Linux kernel development community.  (Sometimes with
> >some help from major system vendors who write in a requirement for a
                  ^^^^^^^^^^^^^^^^^^^^
Do you knwo the contracts, agreements and result of meetings of major of
major system vendors with the sales army of big OS corporations in the
desktop area?
Probably not.

> >mainline device driver into the sourcing contracts for said
> >controllers, but nevertheless, it shows that this stance is not
> >obviously a bad strategy for Linux kernel developers, at least in the
> >server space.)

Perhaps you should ask them (and I mean "ask the folks to pushed and
took the decision and not spokespersons or marketing and sales staff")
"why on earth?".

[...]
> Yes it worked for us. But what about others? I don't think everyone that 
> want to support Linux have to do that. We are different, because we only 
> support Linux, so we dare to do that. Other companies have to do 
> Windows, Unix and possibly other OS. This way don't seems feasible for them.

But it is *their* commercial decision if they play the Linux market (as
long as it exists) and/or if they play the proprietory market (as long
as it exists). As well as it is MSFT decision to play exclusively in the
propriatory market, they and you have to live with it.
Of course we all want the best of all worlds - free software,
out-of-the-box working toolchains and stable APIs through all of them to
minimize my own work. IMHO this is another "choose any 2 of the 3"
question.

> Back-port?

If you want a commercial answer: Either it pays off or not. It is
*their* decision.

> >But at that point it stops being a technical question of "is it
> >possible" and moves to an economic question of "are we willing to fund

Yes, because the free software world generally gives a broad "yes, it is
technically possible" (whereas the propriatory world makes of this the
key selling point).

> >a full-time engineer to provide support for our hardware under Linux"
> >and "how popular does the Linux desktop have to be before a system
> >vendor will feel obliged to put pressure on their downstream suppliers
> >to provide the necessary driver support"?  And as such, LKML will
> >probably not be a very useful place to have that discussion.

Probably wrong. It is completely up to the hardware vendor to decide if
-) they just want to sell their hardware and release specs so that
   everyone can write (and fix) a (free) driver.
-) also have reasons to maintain the drivers themselves over time.
-) just out-source the development and maintenance of a driver.
-) just out-source the development of a driver for the current kernel
   (to you, me, someone), release the source under GPL, throw it into
   the kernel and copnsider (and sell!) it as "maintained".
-) divide the driver in one OS-independent lower part and a OS-dependent
   upper part (whareas the latter is surely under the GPL and with the
   former you have to look at each case) to "hide hardware details"
   for whatever reason.
-) or whatever partial "solutions" (and combinations therof over time)
   come to the mind of some deciders.
*The hardware vendor* (and not me and IMHO not LMKL) has to decide which
fits most in his business plans. *The hardware vendor* makes the money
with after all.

> I have no expectation the LKML will agree to my point . Because 99% of 
> the LKML are likely technical users and community developers. As said, 
This is probably correct:^^^^^^^^^^^^^^^
This is plain simply wrong:               ^^^^^^^^^^^^^^^^^^^^
There are for sure *far* more then 1% who make living with
"Linux" (technically wise).

> they only care about programming drivers in the kernel source. Freedom 
> of change is cool and fun for them.

As long as you want to see (and/or argue) exactly the historically grown
propriatory business model, it certainly doesn't work out.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

