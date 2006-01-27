Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWA0CQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWA0CQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 21:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWA0CQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 21:16:12 -0500
Received: from mail.dvmed.net ([216.237.124.58]:31929 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030207AbWA0CQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 21:16:11 -0500
Message-ID: <43D98259.8090406@pobox.com>
Date: Thu, 26 Jan 2006 21:15:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Simon Barber <simon@devicescape.com>
CC: Michael Buesch <mbuesch@freenet.de>, Ben Greear <greearb@candelatech.com>,
       David Hollis <dhollis@davehollis.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Samuel Ortiz <samuel.ortiz@nokia.com>, netdev@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: wireless geo stuff (was Re: wireless-2.6 status (25 January 2006))
References: <C86180A8C204554D8A3323D8F6B0A29FEB471D@dhost002-46.dex002.intermedia.net>
In-Reply-To: <C86180A8C204554D8A3323D8F6B0A29FEB471D@dhost002-46.dex002.intermedia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Simon Barber wrote: > In order to get FCC certification
	the manufacturer must ensure there is > no easy way for the user to
	tune to illegal frequencies. Broadcom has > done their job - it was not
	easy to reverse engineer their driver. Now > the cat is out of the bag.
	The open source driver is not illegal - > although it may be illegal to
	use it - since the chipset and driver were > likely certified together.
	I'm no expert in FCC regulation, so take all > of this with a pinch of
	salt. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Barber wrote:
> In order to get FCC certification the manufacturer must ensure there is
> no easy way for the user to tune to illegal frequencies. Broadcom has
> done their job - it was not easy to reverse engineer their driver. Now
> the cat is out of the bag. The open source driver is not illegal -
> although it may be illegal to use it - since the chipset and driver were
> likely certified together. I'm no expert in FCC regulation, so take all
> of this with a pinch of salt.

First, kernel developers should do the best they can to provide 
facilities to limit the frequencies, including sane and safe defaults 
for the softmac cases.  It just makes sense to do that, from a "friendly 
neighbor" and "don't operate out of spec" perspective, if nothing else. 
  It's damned _rude_ to use channels other than the ones selected by the 
Responsible Authority.  Some ham radio operator -- like me -- might be 
using that frequency to carry on a pleasant Morse code conversation with 
someone else halfway across the world.  Linux software shalt not be 
rude.  :)

Second, if someone takes steps to disable these safeguards we build in, 
that's akin to putting illegal crystals into a radio, or tuning a 
transmitter to police/emergency bands.

Finally, binary-only software is clearly _not_ a barrier to this sort of 
circumvention.  Reverse engineering x86 software is a skill that's very 
widespread, relative to other sorts of reverse engineering.  Reverse 
engineering tools for the x86 are very mature these days, having had two 
decades to grow and flourish.  If the _hardware_ can be programmed 
maliciously, there's not a whole lot you can do about it... particularly 
when the hardware manufacturer chooses a method of obfuscation (x86 
code) practically designed for easy analysis.

	Jeff


