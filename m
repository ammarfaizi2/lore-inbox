Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVKBNsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVKBNsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVKBNsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:48:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10391 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965033AbVKBNsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:48:22 -0500
Date: Wed, 2 Nov 2005 14:48:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec (fwd)
Message-ID: <20051102134805.GA17136@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Pavel Machek <pavel@suse.cz> -----

To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec
X-Warning: Reading this can be dangerous to your mental health.

Hi!

> > > so you say that the Nokia 6230 has PAN Profile support and you don't
> > > need any PPP crap to get Internet access? This would be the first phone
> > > I have seen so far.
> > 
> > No, sorry, that was over ppp over rfcomm. With MSI dongle, I get
> > 25KB/sec with n6230. With bluetooth CF card, I only get 10KB/sec.
> 
> show me the "hcitool info ..." for the phone.

n6230:

root@bug:~# hcitool info <n6230>
Requesting information ...
        BD Address:  <n6230>
        Device Name: Acces denied
        LMP Version: 1.1 (0x1) LMP Subversion: 0x380
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbf 0xee 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV3 packets> <u-law log>
                <A-law log> <CVSD> <paging scheme> <power control>
                <transparent SCO>
root@bug:~#

> > This is against second linux box... Can't be the phone.
> 
> >From Linux to Linux you can get something around 80KB/sec. Do you have
> any other USB dongle to test this against, because I think the PCMCIA
> card is the problematic part here.

Agreed. PCMCIA billionton seems to limit speed to 10KB/sec :-(.
								Pavel
-- 
Thanks, Sharp!

----- End forwarded message -----

-- 
Thanks, Sharp!
