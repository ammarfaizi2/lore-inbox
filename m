Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVKKTuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVKKTuD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVKKTuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:50:03 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:2918 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751122AbVKKTuB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:50:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A5oxSnKYl5PXKfOVWAjhnp5WGukLtCUOwg2f8raLPOTS25F94M1Zer0KzzwH3SK+K6tSshA42KBGyLjJf81yT0JptF4Xi3cTT/l7aA39nXAhjkReBUIYGGQUUAR1Qa0P8VCmUIi63tUprxInTsLag+jogXv0DGwS9Va5VLiGMiE=
Message-ID: <195c7a900511111149q23db90e7n67ef3cab6694cb78@mail.gmail.com>
Date: Fri, 11 Nov 2005 19:49:59 +0000
From: roucaries bastien <roucaries.bastien@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [BUG] Ali snd soft lookup on 2.6.14 (regression)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <s5h4q6jypi8.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <195c7a900511101418r25aa43e6gc5cdeeac17aa0c7c@mail.gmail.com>
	 <s5hr79nz3b4.wl%tiwai@suse.de>
	 <195c7a900511111040p7947267brd99ce0be3c1130f4@mail.gmail.com>
	 <s5h64qzyq8o.wl%tiwai@suse.de>
	 <195c7a900511111102t240b8195y58a2c167f0185d70@mail.gmail.com>
	 <s5h4q6jypi8.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/05, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 11 Nov 2005 19:02:00 +0000,
> roucaries bastien wrote:
> > > > > Does the patch below fix?
> > > > It fix the BUG but I have always no sound :-(
> > > >
> > > > dmesg shows now:
> > > >
> > > > AC'97 1 does not respond - RESET
> > > > AC'97 1 access is not valid [0xffffffff], removing mixer.
> > >
> > > This is the secondary codec, so it's no fatal error.
> > >
> > > Make sure that you set up your mixer correctly again.
> Toggle 'Headphone Jack Sense' and 'Line Jack Sense' mixer switches.
> Don't touch these switches unless you're sure.

If I toggle off the two switch below it work (with obviously your
patch applied).

Thank you very much for your quick fix.

Bastien
