Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUHSGHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUHSGHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUHSGHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:07:38 -0400
Received: from mout2.freenet.de ([194.97.50.155]:58514 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S265993AbUHSGHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:07:13 -0400
Reply-to: Wolfgang Fritz <wolfgang.fritz@gmx.net>
To: linux-kernel@vger.kernel.org
From: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Subject: Re: ati_remote for medion
Date: Thu, 19 Aug 2004 08:00:39 +0200
Organization: None
Message-ID: <cg1fm7$b76$1@fritz38552.news.dfncis.de>
References: <1092856969.11811.12.camel@kryptonix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en, de-de
In-Reply-To: <1092856969.11811.12.camel@kryptonix>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-8; AVE: 6.27.0.6; VDF: 6.27.0.19; host: gurke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Demeyer wrote:
> I got a remote control with my PC ("Medion 8080 XL titanium") that works
> with an USB-receiver (via radio-waves).  As it was not supported, I
> experimented a bit and found out I could 'use' the ati-remote module in
> the 2.6.x-kernel.  I had to change some stuff like the "#define
> ATI_REMOTE_PRODUCT_ID   0x0006" and then it gave some input for some
> keys.  I also had to change the whole "Translation table from hardware
> messages to input events" which took a lot oftime for me as I had to try
> out very much as I don't know about what I had to use and the keys all
> had other hex-codes then those of the ati-remotes.
> 
> I sent my changes to Torrey Hoffman <thoffman@arnor.net> a long time ago
> and I thought he answered me he would put support for my kind of remote
> in his module, but since then nothing happened in that way.  I'm not a
> coder, so I can't give 'patches' of diffs of whatever ... I even can't
> recode the module to support both remotes ... 
> 

I sent a patch to support the Medion RC to the linux-usb-devel list in
April 04 (http://thread.gmane.org/gmane.linux.usb.devel/20928) but it
got ignored. I think the main problem is to support the different key
mappings in the driver. The easiest approach would be to expand the hard
coded key translation table for each supported RC. If that would be
acceptable, I could prepare a patch.

Is there a another way to handle remote control key mappings in the
input subsystem?

Wolfgang

> My question is: could someone please do this for me?  I spent a lot of
> time on it and I want to give back to the comunnity.  There are more
> people out there using linux who maybe already gave their remote away as
> they couldn't use it with linux.  But I use it for xmms, TVtime, Totem,
> gxine and all those other nice apps.  I don't need my name in the
> credits.  Yours should be if you code it :| ... please ? :)
> 
> friendly greeting,
> 
> Karel "scapor" Demeyer.
> 
> PS: attached is the code with changes (derivated of the ati-remote.c in
> 2.6.8.1)
> 
> 
> 
> 
[cut]


