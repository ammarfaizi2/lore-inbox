Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWHHU2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWHHU2Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWHHU2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:28:24 -0400
Received: from smarthost3.mail.uk.easynet.net ([212.135.6.13]:9747 "EHLO
	smarthost3.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S932227AbWHHU2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:28:24 -0400
Message-ID: <44D8F3E5.5020508@ukonline.co.uk>
Date: Tue, 08 Aug 2006 21:28:21 +0100
From: Andrew Benton <b3nt@ukonline.co.uk>
User-Agent: Thunderbird 3.0a1 (X11/20060804)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ALSA problems with 2.6.18-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello World,
I use the optical digital output from my computer and normally it works
well. However, with a 2.6.18-rc* kernel I have to use alsamixer to get
any output from it. I tweak the levels till it's working and use alsactl
store to save it. Normally, when I reboot it's enough to have a
bootscript run alsactl restore and it should work,  but as I said, with
a 2.6.18-rc* kernel it doesn't. Every time I have to use alsamixer to
change the <IEC958 P> setting to A/D Conv and then back to AC-Link again
to get the diode to come on and start sending a signal to the amplifier.
And the problems don't stop there. At first it sounds fine but after a 
few minutes it starts to develop a harsh, tinny, metallic, distorted 
quality and it becomes unlistenable.

According to alsamixer v1.0.11, the card is an Intel ICH5 and the chip
is an Analog Devices AD1981B

Andy

