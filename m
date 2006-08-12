Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWHLU5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWHLU5E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 16:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWHLU5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 16:57:03 -0400
Received: from rooties.de ([83.246.114.58]:43398 "EHLO rooties.de")
	by vger.kernel.org with ESMTP id S932597AbWHLU5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 16:57:01 -0400
From: Daniel <damage@rooties.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: debug prism wlan
Date: Sat, 12 Aug 2006 22:56:59 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200608122140.44365.damage@rooties.de> <200608122226.26516.damage@rooties.de> <200608122143.04859.s0348365@sms.ed.ac.uk>
In-Reply-To: <200608122143.04859.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608122257.00019.damage@rooties.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 12. August 2006 20:43 schrieb Alistair John Strachan:
> On Saturday 12 August 2006 23:26, Daniel wrote:
> > Oh, sorry I have forgotten to tell:
> >
> > drunken init # lspci |grep Prism
> > 00:08.0 Network controller: Intersil Corporation ISL3890 [Prism GT/Prism
> > Duette]/ISL3886 [Prism Javelin/Prism Xbow] (rev 01)
> >
> > So I'm using the prism54 driver (CONFIG_PRISM54). My version of
> > wireless-tools is 29_pre10 and the version of the used firmware is
> > 1.0.4.3.
>
> I noticed you have the mode set to Master, is this intentional?
>
> I've found my Prism54 (which is an older model, but the same firmware)
> requires me to ifconfig up before I can set iwconfig parameters correctly.
>

Hey, that did it! But now I am a liddle confused. It worked fine before. Why  
does it not work while interface is not up?

regards and BIG thank
Daniel
