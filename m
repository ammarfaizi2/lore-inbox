Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbTFRPrB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 11:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbTFRPrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 11:47:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41989 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265303AbTFRPpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 11:45:30 -0400
Date: Wed, 18 Jun 2003 08:58:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Michael Hunold <hunold@convergence.de>
cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Holger Waechtler <holger@convergence.de>,
       Johannes Stezenbach via CVS <js@convergence.de>
Subject: Re: DVB updates, 3rd try
In-Reply-To: <3EF051AF.1060006@convergence.de>
Message-ID: <Pine.LNX.4.44.0306180849150.9782-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jun 2003, Michael Hunold wrote:
> 
> again I hope to get the LinuxTV.org CVS "dvb-kernel" driver in
> sync with the latest 2.5 kernel.
> 
> The main project page is http://www.linuxtv.org.
> 
> It's a patchset of 10 patches -- due to the size of some of the
> patches, I don't post them on the list again.

I don't go out to fetch patches, I really want to see them come to me (and
even then preferably through a few people acting as quality control and
maintainership).

And if there is no clear maintainership relationship and you need to send
them directly to me, I really want plain-text patches (they can be big if
needed), with:

 - one patch per email. Not attachements, and not several patches in one 
   email one after the other. Several emails, with one patch each, and if 
   they are interdependent, make the subject line be something like

	[DVB PATCH 1/9] Replace frobutomic counter with sequence numbers

   so that when they get re-ordered by the email system (as they 
   inevitably will be), I can see it from the overview.

   The "[xxx]" syntax is important: my scripts will automatically strip 
   that part out and replace it with "PATCH", leaving the commit message
   as just

	[PATCH] Replace frobutomic counter with sequence numbers

   since once it's in the tree, the ordering is implicit in the SC.

 - explanation of the patch for the changelogs at the top of the patch, so 
   that I don't have to make up my own explanations for what it does and
   get it wrong.

 - Make sure your mailer doesn't corrupt the message with whitespace 
   damage (spaces at ends of lines should remain, and tabs should be 
   tabs), or with stupidities like 7-bit quoted-printable crap.

Please.

		Linus

