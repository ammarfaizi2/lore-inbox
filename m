Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVCAUr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVCAUr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVCAUrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:47:22 -0500
Received: from mail.tmr.com ([216.238.38.203]:62468 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262061AbVCAUoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:44:03 -0500
Date: Tue, 1 Mar 2005 15:32:15 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: James Bruce <bruce@andrew.cmu.edu>
cc: Paulo Marques <pmarques@grupopie.com>, Gerd Knorr <kraxel@bytesex.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
In-Reply-To: <42248DE0.9090003@andrew.cmu.edu>
Message-ID: <Pine.LNX.3.96.1050301152915.13613A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2005, James Bruce wrote:

> Sorry, I wasn't clear in the previous email; I did try the card= option 
> anyway.  I wrote a looping script and tested first 70 card= options, and 
> none worked properly for streaming capture.  Some did show different 
> behavior though.  I might try the remaining 50 later today.
> 
> I did notice one strange thing though; the card= option is only applied 
> to the first bttv card.  All remaining cards in the system are still 
> autodetected (which ends up assuming card=0 in my case).  Not sure if 
> this is the intended behavior or not, since someone really could run two 
> different bttv cards in the same system.

Just for grins, did you try pulling one of the cards? I have to guess that
having multiple cards is a low occurence configuration, and that you *may*
be following some less traveled path here.

At least now that you know how to set the type for the cards separately
you can test two configurations at a time.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

