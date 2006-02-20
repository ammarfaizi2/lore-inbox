Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWBTBdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWBTBdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 20:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWBTBdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 20:33:19 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:58893 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932508AbWBTBdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 20:33:18 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: No sound from SB live!
Date: Mon, 20 Feb 2006 01:33:26 +0000
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, ghrt <ghrt@dial.kappa.ro>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       tiwai@suse.de
References: <20060218231419.GA3219@elf.ucw.cz> <1140395634.2733.450.camel@mindpipe> <20060220003939.GH15608@elf.ucw.cz>
In-Reply-To: <20060220003939.GH15608@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602200133.26293.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 00:39, Pavel Machek wrote:
> On Ne 19-02-06 19:33:54, Lee Revell wrote:
> > On Sun, 2006-02-19 at 22:44 +0100, Pavel Machek wrote:
> > > Hi!
> > >
> > > > > I tried enabled everything I could in alsamixer, but still could
> > > > > not get it to produce some sound :-(.
> > > >
> > > > Is 2.6.15.4 also broken?
> > >
> > > 2.6.15.4 does not have support for my SATA controller, so it would be
> > > quite complex to test that... I may have something wrong with
> > > userspace, but alsamixer all to max, then cat /bin/bash > /dev/dsp
> > > should produce some sound, no?
> >
> > So this isn't necessarily a regression - it's possible this device never
> > worked?
> >
> > Creative has been known in the past to release 2 devices with identical
> > serial numbers and different AC97 codecs.  Stuff like this is why it's
> > almot impossible to prevent all driver regressions unless you can test
> > every supported card...
>
> It did work _long_ time ago, and in different machine. Definitely not
> in 2.6.15... maybe in 2.6.5.

With ALSA? Any chance the card is physically damaged? Try using the OSS driver 
if it's still around, then you'll have a solid case to take up with Takashi.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
