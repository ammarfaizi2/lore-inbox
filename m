Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVCAQIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVCAQIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 11:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVCAQIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 11:08:47 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:24724 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261939AbVCAQIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 11:08:39 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 1 Mar 2005 17:03:27 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Paulo Marques <pmarques@grupopie.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
Message-ID: <20050301160327.GB4595@bytesex>
References: <42232DFC.6090000@andrew.cmu.edu> <4223A5C3.6010000@tmr.com> <42241491.2060303@andrew.cmu.edu> <42247822.7030107@grupopie.com> <42248DE0.9090003@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42248DE0.9090003@andrew.cmu.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did notice one strange thing though; the card= option is only applied 
> to the first bttv card.  All remaining cards in the system are still 
> autodetected (which ends up assuming card=0 in my case).  Not sure if 
> this is the intended behavior or not, since someone really could run two 
> different bttv cards in the same system.

Intentional.  Try "insmd bttv card=3,4" ...

  Gerd

