Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWEGQiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWEGQiV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWEGQiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 12:38:21 -0400
Received: from waste.org ([64.81.244.121]:3462 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932194AbWEGQiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 12:38:20 -0400
Date: Sun, 7 May 2006 11:33:19 -0500
From: Matt Mackall <mpm@selenic.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Lee Revell <rlrevell@joe-job.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060507163319.GO15445@waste.org>
References: <2.420169009@selenic.com> <8.420169009@selenic.com> <20060505.141040.53473194.davem@davemloft.net> <20060506140850.GN25646@vanheusden.com> <1146928743.15364.89.camel@mindpipe> <20060507103507.GV25646@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060507103507.GV25646@vanheusden.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 12:35:08PM +0200, Folkert van Heusden wrote:
> > > Consider adding a cheap soundcard to the system and run
> > > 'audio-entropyd': www.vanheusden.com/aed 
> > Can't get much cheaper than the crap that comes on every motherboard
> > these days ;-)
> > Also aren't temp sensors (on the disk or mobo) a good entropy source?
> 
> Not sure about that. If I look at
> http://keetweej.vanheusden.com/draw_temp.php?limit=86400 it looks like
> that at least the cpu sensor gets only updated every x seconds.

Yeah, heat sensors are not terribly useful. Thermal insulation acts as
a very aggressive low pass filter on whatever noise might exist in the
input.

-- 
Mathematics is the supreme nostalgia of our time.
