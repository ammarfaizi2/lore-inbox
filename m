Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272261AbTG3VGO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272257AbTG3VEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:04:50 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:56782 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S272256AbTG3VEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:04:15 -0400
Date: Wed, 30 Jul 2003 23:04:14 +0200
From: bert hubert <ahu@ds9a.nl>
To: Richard A Nelson <cowboy@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1 & ipsec-tools (xfrm_type_2_50?)
Message-ID: <20030730210414.GA28308@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Richard A Nelson <cowboy@vnet.ibm.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0307301515250.26621@onqynaqf.yrkvatgba.voz.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0307301515250.26621@onqynaqf.yrkvatgba.voz.pbz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 04:22:25PM -0400, Richard A Nelson wrote:
> 
> I built ipsec-tools against the 2.6.0-test2-mm1 includes and am *so*
> close to getting it to work...

I recently tested all this again with 2.6.0-test2 and It Just Worked, so I
can't confirm this.

> modprobe: FATAL: Module xfrm_type_2_50 not found.
> ERROR: pfkey.c:209:pfkey_handler(): pfkey UPDATE failed:
> 	 No buffer space available
> ERROR: pfkey.c:209:pfkey_handler(): pfkey ADD failed: No buffer space available
> 
> all the ipsec and crypto stuff is modular, for the nonce, until I figure
> what I need/want.
> 
> most of the module not found messages are fine, its xfrm_type_2_50 that
> I'm worried about... What am I missing ?

I run with a very minimal racoon.conf, almost exactly the one found on
http://lartc.org/howto/lartc.ipsec.html

I'd suggest posting the relevant bits of your .config

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
