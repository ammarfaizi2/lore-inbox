Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWHIW2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWHIW2p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWHIW2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:28:45 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:64780 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751406AbWHIW2o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:28:44 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ALSA problems with 2.6.18-rc3
Date: Wed, 9 Aug 2006 23:28:47 +0100
User-Agent: KMail/1.9.4
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Andrew Benton <b3nt@ukonline.co.uk>, Takashi Iwai <tiwai@suse.de>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
References: <44D8F3E5.5020508@ukonline.co.uk> <200608092307.27615.s0348365@sms.ed.ac.uk> <1155161498.26338.216.camel@mindpipe>
In-Reply-To: <1155161498.26338.216.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608092328.47039.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 23:11, Lee Revell wrote:
> On Wed, 2006-08-09 at 23:07 +0100, Alistair John Strachan wrote:
[snip]
> > However, ALSA _has_ defaults for these controls, which I believe are
> > usually "off" or "zero". All I'm suggesting is that these defaults are
> > plainly suboptimal for emu10k1, and probably other cards to which this
> > statement simply does not apply. Shipping defaults is one thing, but
> > shipping useless defaults is quite another. We have policy all over
> > the kernel for providing "sane defaults" e.g. filesystem mount
> > options.
>
> I think muted is a sane default - the only sane default.  Otherwise you
> could damage speakers or hearing.  Also many devices will be noisier if
> unused inputs are enabled.  Is it really that hard for users to unmute
> the mixer or for distros to create their own config?

I think this argument is mostly deflated by the fact that other 
multimedia-centric operating systems do not ship with controls muted. If 
hardware is detected, all sliders are set to 50%. I think this is superior.

As you pointed out, it probably is best left to distros. I just can't help 
thinking that there might be some scope for improving the default state of 
boolean tunables, even if sliders are left at zero.

> Also, analog output on my emu10k1 works perfectly with "External
> Amplifier" disabled.

Interesting, evidence in your favour. It does not work here. It also did not 
work on the AC'97 in my HP NC6000, which also has External something-or-other 
and which also defaulted to "off".

Took some figuring out. :-)

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
