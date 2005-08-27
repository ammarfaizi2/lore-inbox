Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVH0VR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVH0VR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 17:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVH0VR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 17:17:28 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:47830 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750786AbVH0VR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 17:17:28 -0400
Date: Sat, 27 Aug 2005 17:17:26 -0400
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Surround via SPDIF with ALSA/emu10k1?
Message-ID: <20050827211726.GD28578@csclub.uwaterloo.ca>
References: <1124755373.5763.4.camel@hostmaster.org> <1125166739.22285.66.camel@hostmaster.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125166739.22285.66.camel@hostmaster.org>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2005 at 08:18:59PM +0200, Thomas Zehetbauer wrote:
> I have now been told that SPDIF cannot support more than 2 channels
> except with AC3 compression. Given the fact that we can send 580MBit/s
> over USB2.0 I would not have even remotely considered this to be the
> problem and find it an incredible shame that audio industry is using
> such a crippled standard.
> 
> I have now solved my problem by buying and connecting an analog 5.1
> speaker set. Unfortunately I get audible distortions when I turn both
> the "PCM" and "Wave" mixers to the maximum setting. I wonder if anyone
> can provide more insight what these controls really do and whether it's
> better to turn down "PCM", "Wave" or both.

I thought the limitation on SPDIF was normally that most decoders only
support 2 channels of PCM, except for a few multimedia speaker systems
which support 3 pairs of PCM streams at the same time to support digital
out on some sound cards.

Most digital decoders do support AC3 of course and sometimes also DTS
both of which of course support encoding more than 2 channels.

So really I think it is just a problem of what standards the receivers of
the digital data know what to do with.

As for volume settings, I always try to keep the sound card mixers at
around 75 to 80% since it seems most amplifiers and mixer do distort a
bit when you max them out.  Why would you want them all at 100% anyhow,
then you might as well not have mixing control for the seperate audio
channels at all.

Len Sorensen
