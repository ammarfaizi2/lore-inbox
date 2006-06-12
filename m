Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWFLJhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWFLJhc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWFLJhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:37:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51079 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751375AbWFLJhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:37:31 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernd Petrovitsch <bernd@firmix.at>,
       Matti Aarnio <matti.aarnio@zmailer.org>
Cc: jdow <jdow@earthlink.net>, davids@webmaster.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1150100286.26402.13.camel@tara.firmix.at>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	 <193701c68d16$54cac690$0225a8c0@Wednesday>
	 <1150100286.26402.13.camel@tara.firmix.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jun 2006 10:53:24 +0100
Message-Id: <1150106004.22124.155.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-12 am 10:18 +0200, ysgrifennodd Bernd Petrovitsch:
> No. SPF simply defines legitimate outgoing MTAs for a given domain.

No it does not. If it did it would be almost a usable idea, but it fails
because the ISP generally controls the definition and the users are more
mobile so they want to send via other paths too. Going via the users
home box is often impractical because of firewalls and also ISP controls
like dynamic IP. It is a technical solution to the wrong problem because
it was designed by people some of whom are ignorant of the real world
and the other half of whom saw it as a differentiator and a further
profit potential.

Spammers *love* SPF because they can register 30 day knock down unpaid
domains and people score them as non spam.

ISPs *love* SPF because they can enforce policies that allow them to
charge even more to users who want to do anything interesting. The fact
many of them don't allow users to control their own domain SPF or get a
fixed SPF pointing at the ISP mailhost only is not entirely that they
haven't gotten around to fixing it either.

The people who suffer from SPF are unfortunately the users. The people
its alleged to stop like it. The people it is alleged to help run
filters get richer and the users get screwed.

For Vger it isn't too bad, it'll just break all the people relaying or
cc'ing vger mail to an ISP account, and probably those people Cc'ing it
to some HTML based list archiving sites. 

I find Matti's comments about "first-class citizens" distasteful. What
do you want Matti, a world where you have to be "<--- this --->" 'L33T
to post email ? Knowledge and responsibility are not the same thing, as
usenet Approved headers showed.

SPF *would* be wonderful if the users controlled SPF handling and
someone fixed the forwarding flaws in it, but neither is the case today.

Alan

