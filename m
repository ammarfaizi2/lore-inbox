Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVCZAin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVCZAin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 19:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVCZAin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 19:38:43 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:6271 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261895AbVCZAie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 19:38:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=LPZMqvaTgs97ZCHfDCuAgYLADw6yzeCBqqo0KAqd7pTJou8Xs/XincNPp94wLSMhkr2H63CtZEOiUjwuMT4+1wJ4E4vObZBaCeHuJJiPBV8Fae4k/GSxrEa3+xx1DQsaqIAjhz9mpfljgG5GaOTwYnCWbc9O0z21As40zJ7H59c=
Message-ID: <2a0fbc590503251638420f2f08@mail.gmail.com>
Date: Sat, 26 Mar 2005 01:38:34 +0100
From: Julien Wajsberg <julien.wajsberg@gmail.com>
Reply-To: Julien Wajsberg <julien.wajsberg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
In-Reply-To: <1111792462.23430.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <2a0fbc59050325145935a05521@mail.gmail.com>
	 <1111792462.23430.25.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 18:14:22 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> > - audio works too. The only problem is that two applications can't
> > open /dev/dsp in the same time.
> 
> Not a problem.  ALSA does software mixing for chipsets that can't do it
> in hardware.  Google for dmix.
> 
> However this doesn't (and can't be made to) work with the in-kernel OSS
> emulation (it works fine with the alsa-lib/libaoss emulation).  So you
> are technically correct in that two OSS apps can't open /dev/dsp at the
> same time, but there is no problem with multiple apps sharing the sound
> device, as long as they use the ALSA API (which they should be using
> anyway).

Okay, good to know. Then I'll have to find out why beep-media-player
doesn't work with alsa :-)

-- 
Julien
