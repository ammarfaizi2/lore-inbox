Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWC0IcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWC0IcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 03:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWC0IcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 03:32:03 -0500
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:10486 "EHLO
	mailgate2.urz.uni-halle.de") by vger.kernel.org with ESMTP
	id S1750806AbWC0IcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 03:32:01 -0500
Date: Mon, 27 Mar 2006 10:31:13 +0200
From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-devel] [ALSA] AdLib FM card driver
In-reply-to: <442710A1.5030207@keyaccess.nl>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <20060327083113.GB2521@turing.informatik.uni-halle.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <442710A1.5030207@keyaccess.nl>
X-Scan-Signature: 8a46a9913181300b63c8a1b6a7c824fb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> [...]
> I also stuck a very tiny HOWTO in ALSA-Configuration.txt, assuming quite 
> a few people would have no idea how to operate the thing, even if they 
> do happen across a card. Is it okay there?

It should probably go into a seperate file below Documentation/.

> + This module supports multiple cards. It does not support autoprobe, so
> + the port must be specified. For actual AdLib FM cards it will be 0x388.

Does it make sense to support more than one card or a non-default port
address?  I.e., is there any card using an OPL2/3 that we do not have a
driver for (except the AdLib FM)?

I think at least the port address for the first card should be defaulted
to 0x388.


Regards,
Clemens
