Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWATMlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWATMlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWATMlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:41:39 -0500
Received: from audible.transient.net ([216.254.12.79]:10633 "HELO
	audible.transient.net") by vger.kernel.org with SMTP
	id S1750929AbWATMli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:41:38 -0500
Date: Fri, 20 Jan 2006 04:41:36 -0800
From: Jamie Heilman <jamie@audible.transient.net>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060120124136.GB8967@fifty-fifty.audible.transient.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ek34vucz.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> > SOUND_MSNDCLAS
> > SOUND_MSNDPIN
> 
> Turtle Beach, I think it's newer than (at least the original) GUS.

Makes me sad to see this one get so stale.  The Fiji and Pinnacle
cards sounded really good and had excellent noise characteristics for
their period of manufacture.  The ALSA driver (not in the kernel tree)
has never worked for me; xruns like crazy during playback, apparently
due to a different buffering approach (aimed at lower latency) from
the OSS driver.  But support has suffered ever since 2.6 landed.  I
opened a bug on the OSS driver (http://bugme.osdl.org/show_bug.cgi?id=1709)
ages ago and it never really went anywhere.  Last time I tried the OSS
driver (even with the fixes mentioned in bug 1709) it didn't work at
all, and so I gave up on using my Fiji with newer kernels.  I have a
friend who even wrote his own pndsperm firmware to handle AC3 digital
output from his Multisound card (though he was never happy with the audio
quality).  Anyway, if some attention is given to the ALSA msnd driver
again I'd be happy to test.
