Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWHLVHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWHLVHZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWHLVHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:07:25 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:18189 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S932600AbWHLVHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:07:24 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Daniel <damage@rooties.de>
Subject: Re: debug prism wlan
Date: Sat, 12 Aug 2006 22:07:29 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200608122140.44365.damage@rooties.de> <200608122143.04859.s0348365@sms.ed.ac.uk> <200608122257.00019.damage@rooties.de>
In-Reply-To: <200608122257.00019.damage@rooties.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122207.29924.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 August 2006 23:56, Daniel wrote:
> Am Samstag, 12. August 2006 20:43 schrieb Alistair John Strachan:
> > On Saturday 12 August 2006 23:26, Daniel wrote:
> > > Oh, sorry I have forgotten to tell:
> > >
> > > drunken init # lspci |grep Prism
> > > 00:08.0 Network controller: Intersil Corporation ISL3890 [Prism
> > > GT/Prism Duette]/ISL3886 [Prism Javelin/Prism Xbow] (rev 01)
> > >
> > > So I'm using the prism54 driver (CONFIG_PRISM54). My version of
> > > wireless-tools is 29_pre10 and the version of the used firmware is
> > > 1.0.4.3.
> >
> > I noticed you have the mode set to Master, is this intentional?
> >
> > I've found my Prism54 (which is an older model, but the same firmware)
> > requires me to ifconfig up before I can set iwconfig parameters
> > correctly.
>
> Hey, that did it! But now I am a liddle confused. It worked fine before.
> Why does it not work while interface is not up?

I'm not sure, but I think you've just been lucky. I've had this problem even 
before prism54 was merged. Some in-tree drivers won't upload the firmware 
until you ifconfig up them, which obviously means they won't respond 
adequately to the wireless extension requests. Maybe a bug?

> regards and BIG thank

No problem.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
