Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUATFiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 00:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbUATFiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 00:38:05 -0500
Received: from magic.adaptec.com ([216.52.22.17]:41172 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S265060AbUATFh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 00:37:59 -0500
Date: Mon, 19 Jan 2004 22:43:41 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Xose Vazquez Perez <xose@wanadoo.es>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
Message-ID: <4022195408.1074577421@aslan.btc.adaptec.com>
In-Reply-To: <1074573912.2081.81.camel@mulgrave>
References: <400BDC85.8040907@wanadoo.es>	<1074532919.1895.32.camel@mulgrave>		<3747775408.1074537497@aslan.btc.adaptec.com>	<1074559838.2078.1.camel@mulgrave> 	<3942145408.1074564149@aslan.btc.adaptec.com> <1074573912.2081.81.camel@mulgrave>
X-Mailer: Mulberry/3.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2004-01-19 at 21:02, Justin T. Gibbs wrote:
>> Does the maintainer have the ability to veto changes that harm the
>> code they maintain?  In otherwords, you claim that I am the maintainer
>> of the drivers in the kernel.org tree.  This has not prevented changes
>> from being made to these drivers without adequate review.  Even your last
>> update to the driver threw away all of the changelog state and left at
>> least the aic79xx driver in a worse state than it was in before (see
>> changelog entries for the driver versions after the one that you imported
>> for details - this was exactly why I didn't submit that particular revision).
> 
> I said "works with the kernel community".  It's not about control, it's
> about co-operation.  The control you seek simply does not exist in the
> kernel development process.

Then I ask again, what does it mean to be a maintainer?  It sounds like
I'm on equal footing with anyone who decides to post some patch to the
lists.  I've lost count of the number of occasions that some random
patch from some random individual was accepted without any consultation
with "the maintainer" of these drivers.  The end result was more email
in my mailbox complaining about "the broken driver that I maintain."

As for control, the type of control "I seek" does exist.  You have it.
You can also delegate some of that control if it suits you.

A maintainer takes on responsibility to ensure that something is maintained
and works.  Without some level of control, how can the maintainer fulfill
that responsibility?

>> You didn't even bother to ask me if importing 1.3.11 was appropriate.  This
>> is why I say I don't feel like a maintainer.  I'm not given adequate control
>> over the end product yet I'm supposed to take the blame when it doesn't work.
> 
> In the previous thread about the driver you said "You can integrate the
> driver at whatever revision suits you.", so I took you at your word; if
> that wasn't what you meant, it's a little late to whine about it now. 
> Small bug fixes, would, as ever, be welcome...

I provided all of the information required for you to make a reasoned
decision of which change sets to integrate.  I had no idea that you
would completely disregard the wealth of information in the change sets
and change set comments when coming up with an integration point.  Your
actions show that you didn't review or understand the changes well enough
to submit them into the tree.  You probably didn't even test the resulting
driver on real hardware before you submitted the changes.

> The recovery code does work.  You may want it to work differently, and
> that may make it work better, but that's an enhancement not a bug fix.

No.  The recovery code doesn't work.  Many of the people that know this
don't bother complaining to you about it.  They complain to the HBA driver
authors and the tech support departments of the companies that make the HBAs.
The HBA driver authors then do what they have to ensure that the system
remains viable after recovery.  

I mean honestly.  Do you think I would have gone to all of the trouble
I did in doing my own watchdog recovery if the recovery code worked
correctly?  Or that I would stand so firm in my position if these issues
didn't have real customer impact?

--
Justin

