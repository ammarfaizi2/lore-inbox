Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbWHXVcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWHXVcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422677AbWHXVcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:32:17 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:10699 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1422676AbWHXVcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:32:16 -0400
Date: Thu, 24 Aug 2006 23:31:14 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20060824213114.GA18667@linuxtv.org>
References: <32640.1156424442@warthog.cambridge.redhat.com> <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org> <20060824155814.GL19810@stusta.de> <Pine.LNX.4.61.0608241838430.16422@yvahk01.tjqt.qr> <20060824164808.GN19810@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824164808.GN19810@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 84.189.240.65
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006, Adrian Bunk wrote:
> On Thu, Aug 24, 2006 at 06:39:14PM +0200, Jan Engelhardt wrote:
> > >> On Thu, 2006-08-24 at 17:29 +0200, Adrian Bunk wrote:
> > >> >         bool "Enable the block layer" depends on EMBEDDED 
> > >> 
> > >> Please. no. CONFIG_EMBEDDED was a bad idea in the first place -- its
> > >> sole purpose is to pander to Aunt Tillie.
> > >
> > >It's not for Aunt Tillie.
> > >It's for an average system administrator who compiles his own kernel.
> > >
> > >CONFIG_BLOCK=n will only be for the "the kernel must become as fast as 
> > >possible, and I really know what I'm doing" people.
> > 
> > Then that should be CONFIG_I_AM_AN_EXPERT (CONFIG_EXPERT), not 
> > CONFIG_EMBEDDED.
> 
> It makes sense that there is one option only for additional space 
> savings.
> 
> But you are right, we need a second option for not space related expert 
> options.

I think the sole purpose of CONFIG_EMBEDDED is to reduce noise from
silly pseudo-bug reports. The rather uninteresting name helps.
If you have CONFIG_EXPERT, of course _everone_ will enable it,
shoot themselves in the foot and will be happy to inform you
about it, wasting their and _your_ time.


Johannes
