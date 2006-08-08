Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWHHVvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWHHVvE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWHHVvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:51:03 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59340 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030193AbWHHVvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:51:02 -0400
Subject: Re: ALSA problems with 2.6.18-rc3
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Benton <b3nt@ukonline.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44D8F3E5.5020508@ukonline.co.uk>
References: <44D8F3E5.5020508@ukonline.co.uk>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 17:50:52 -0400
Message-Id: <1155073853.26338.112.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 21:28 +0100, Andrew Benton wrote:
> Hello World,
> I use the optical digital output from my computer and normally it works
> well. However, with a 2.6.18-rc* kernel I have to use alsamixer to get
> any output from it. I tweak the levels till it's working and use alsactl
> store to save it. Normally, when I reboot it's enough to have a
> bootscript run alsactl restore and it should work,  but as I said, with
> a 2.6.18-rc* kernel it doesn't. Every time I have to use alsamixer to
> change the <IEC958 P> setting to A/D Conv and then back to AC-Link again
> to get the diode to come on and start sending a signal to the amplifier.
> And the problems don't stop there. At first it sounds fine but after a 
> few minutes it starts to develop a harsh, tinny, metallic, distorted 
> quality and it becomes unlistenable.
> 
> According to alsamixer v1.0.11, the card is an Intel ICH5 and the chip
> is an Analog Devices AD1981B

Please try to identify the change that introduced the regression.  What
was the last kernel/ALSA version that worked correctly?

Lee

