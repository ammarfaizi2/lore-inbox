Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbWHLU03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWHLU03 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 16:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWHLU03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 16:26:29 -0400
Received: from rooties.de ([83.246.114.58]:51151 "EHLO rooties.de")
	by vger.kernel.org with ESMTP id S932595AbWHLU02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 16:26:28 -0400
From: Daniel <damage@rooties.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: debug prism wlan
Date: Sat, 12 Aug 2006 22:26:26 +0000
User-Agent: KMail/1.9.1
References: <200608122140.44365.damage@rooties.de> <200608122115.08419.s0348365@sms.ed.ac.uk>
In-Reply-To: <200608122115.08419.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122226.26516.damage@rooties.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, sorry I have forgotten to tell:

drunken init # lspci |grep Prism
00:08.0 Network controller: Intersil Corporation ISL3890 [Prism GT/Prism 
Duette]/ISL3886 [Prism Javelin/Prism Xbow] (rev 01)

So I'm using the prism54 driver (CONFIG_PRISM54). My version of wireless-tools 
is 29_pre10 and the version of the used firmware is 1.0.4.3.

BTW: I tried
# modprobe prism54 pc_debug=1

and 

# modprobe prism54 pc_debug=9999999

But it doesn't increased the verbose level.

The firmware upload was successfull (according to dmesg).

Am Samstag, 12. August 2006 20:15 schrieben Sie:
> On Saturday 12 August 2006 22:40, Daniel wrote:
> > Hi,
> > my wlan gives up working somewhere between upgrading to gcc-4.1, changing
> > some kernel options and upgrading to linux-2.8.16-r4.
>
> Hi Daniel,
>
> Which driver does this card use? There's a couple Prism 1/2/2.5 802.11b
> drivers and a Prism54 driver for 802.11g cards. Any ideas?
