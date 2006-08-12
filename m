Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWHLUtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWHLUtf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 16:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWHLUtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 16:49:35 -0400
Received: from rooties.de ([83.246.114.58]:58576 "EHLO rooties.de")
	by vger.kernel.org with ESMTP id S1422685AbWHLUtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 16:49:35 -0400
From: Daniel <damage@rooties.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: debug prism wlan
Date: Sat, 12 Aug 2006 22:49:33 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200608122140.44365.damage@rooties.de> <200608122115.08419.s0348365@sms.ed.ac.uk> <200608122226.26516.damage@rooties.de>
In-Reply-To: <200608122226.26516.damage@rooties.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122249.33329.damage@rooties.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*grrrr* it is too late on evening (I'm living in germany ;) )...

I also fogot to tell following:

Error for wireless request "Set Frequency" (8B04) :
    SET failed on device eth2 ; Input/output error.

I got this message if I try to start the net device with the init.d script.
If I try to set the channel per hand I got no error but the channel gets not 
set (it still is 0). But I am able to set the mode and the essid.

Any ideas?

Daniel


Am Samstag, 12. August 2006 22:26 schrieb Daniel:
> Oh, sorry I have forgotten to tell:
>
> drunken init # lspci |grep Prism
> 00:08.0 Network controller: Intersil Corporation ISL3890 [Prism GT/Prism
> Duette]/ISL3886 [Prism Javelin/Prism Xbow] (rev 01)
>
> So I'm using the prism54 driver (CONFIG_PRISM54). My version of
> wireless-tools is 29_pre10 and the version of the used firmware is 1.0.4.3.
>
> BTW: I tried
> # modprobe prism54 pc_debug=1
>
> and
>
> # modprobe prism54 pc_debug=9999999
>
> But it doesn't increased the verbose level.
>
> The firmware upload was successfull (according to dmesg).
>
> Am Samstag, 12. August 2006 20:15 schrieben Sie:
> > On Saturday 12 August 2006 22:40, Daniel wrote:
> > > Hi,
> > > my wlan gives up working somewhere between upgrading to gcc-4.1,
> > > changing some kernel options and upgrading to linux-2.8.16-r4.
> >
> > Hi Daniel,
> >
> > Which driver does this card use? There's a couple Prism 1/2/2.5 802.11b
> > drivers and a Prism54 driver for 802.11g cards. Any ideas?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
