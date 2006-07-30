Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWG3V4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWG3V4c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWG3V4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:56:32 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:32438 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S932460AbWG3V4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:56:31 -0400
Date: Sun, 30 Jul 2006 23:55:09 +0200
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, bunk@stusta.de, lethal@linux-sh.org,
       hirofumi@mail.parknet.co.jp, asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060730215509.GA3662@kiste.smurf.noris.de>
References: <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost> <20060724171711.GA3662@kiste.smurf.noris.de> <20060724175150.GD50320@muc.de> <1153774443.12836.6.camel@localhost> <20060730020346.5d301bb5.akpm@osdl.org> <20060730201005.GA85093@muc.de> <20060730211359.GZ3662@kiste.smurf.noris.de> <1154294444.2941.50.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154294444.2941.50.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Arjan van de Ven:
> if the hardware side is different *speed*.. then a tsc sync ain't going
> to work... sure we write to it but it's immediately out of sync again
> 
No, it's in fact the same speed -- the BIOS just reads it wrongly.

I checked: the two date values do advance at the same rate.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"We need not invite the Devil to our table; he is too ready to come
 without being asked. The air all about us is filled with demons...."
                    [Martin Luther]
