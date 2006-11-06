Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWKFH4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWKFH4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 02:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWKFH4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 02:56:05 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:11394 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030376AbWKFH4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 02:56:02 -0500
Message-ID: <454EEA84.4060805@garzik.org>
Date: Mon, 06 Nov 2006 02:55:48 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Auke Kok <auke-jan.h.kok@intel.com>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       stable@vger.kernel.org, rjw@sisk.pl, bunk@stusta.de, akpm@osdl.org,
       laurent.riffard@free.fr, rajesh.shah@intel.com, toralf.foerster@gmx.de,
       pavel@ucw.cz, jesse.brandeburg@intel.com,
       "Ronciak, John" <john.ronciak@intel.com>,
       "John W. Linville" <linville@tuxdriver.com>, nhorman@redhat.com,
       cluebot@fedorafaq.org, notting@redhat.com, bruce.w.allan@intel.com,
       davej@redhat.com, linville@redhat.com, wtogami@redhat.com,
       dag@wieers.com, error27@gmail.com,
       e1000-list <e1000-devel@lists.sourceforge.net>
Subject: Re: [PATCH] e1000: Fix regression: garbled stats and irq allocation
 during swsusp
References: <454B9BED.306@intel.com>
In-Reply-To: <454B9BED.306@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok wrote:
> 
> e1000: Fix regression: garbled stats and irq allocation during swsusp
> 
> After 7.0.33/2.6.16, e1000 suspend/resume left the user with an enabled
> device showing garbled statistics and undetermined irq allocation state,
> where `ifconfig eth0 down` would display `trying to free already freed 
> irq`.
> 
> Explicitly free and allocate irq as well as powerup the PHY during resume
> fixes.
> 
> Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>

ACK, but:

Applying 'e1000: Fix regression: garbled stats and irq allocation during 
swsusp'

fatal: corrupt patch at line 8
