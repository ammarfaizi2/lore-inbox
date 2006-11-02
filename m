Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752646AbWKBV1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbWKBV1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752640AbWKBV1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:27:18 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:31212 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1752628AbWKBV1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:27:17 -0500
Date: Thu, 2 Nov 2006 13:26:28 -0800
To: Ivan Matveich <ivan.matveich@gmail.com>
Cc: Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com, netdev@vger.kernel.org,
       breed@users.sourceforge.net, achirica@users.sourceforge.net,
       fabrice@bellet.info
Subject: Re: [airo.c bug] Couldn't allocate RX FID / Max tries exceeded when issueing command
Message-ID: <20061102212628.GA6235@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <b5def3a40611011914v59ecd4c3xb6965591524aa11@mail.gmail.com> <1162483971.2646.9.camel@localhost.localdomain> <b5def3a40611021030s1b73daa1k2055e5f4373fa746@mail.gmail.com> <1162494679.3347.8.camel@localhost.localdomain> <b5def3a40611021321h22ec79c3x51a54ec7d5b07b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5def3a40611021321h22ec79c3x51a54ec7d5b07b3@mail.gmail.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 04:21:16PM -0500, Ivan Matveich wrote:
> On 11/2/06, Dan Williams <dcbw@redhat.com> wrote:
> >Do you know which kernel version that patch first appeared in?
> 
> It was committed on 1 Dec 2005, and 2.6.15 was released on 3 Jan 2006.
> 
> >That would be a great idea, let us know what the results are, especially
> >if you cna figure out which firmware version you have, or if the card
> >itself is really just dead.
> 
> No luck with freebsd: error resetting card.
> 
> I'll try my luck with Cisco's Windows utility---probably
> tomorrow---but I'd now wager that my card has simply croaked. (I've
> even taken it out and re-seated it in its slot, just in case that
> helped.) In any case, thanks for the help.

	Just remembered... Check the IRQ allocation. I remmeber having
issues with the BIOS not doing the right stuff.

	Jean

