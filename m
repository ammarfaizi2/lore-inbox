Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUIWPo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUIWPo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUIWPo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:44:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:1218 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266362AbUIWPow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:44:52 -0400
Date: Thu, 23 Sep 2004 08:39:08 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Michael Hoeller" <Michael_Hoeller@hugoboss.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: watchdog
Message-Id: <20040923083908.40e2fc5e.rddunlap@osdl.org>
In-Reply-To: <OF9A7DD331.25E3D3B0-ON41256F18.004ADF18-41256F18.004B045D@eu.hugoboss.com>
References: <OF9A7DD331.25E3D3B0-ON41256F18.004ADF18-41256F18.004B045D@eu.hugoboss.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 14:39:30 +0100 Michael Hoeller wrote:

| Hello,
| 
| I would like to swicht on the software watchdog functionality on a 2.6 
| kernel. Unfortunately I did not understand how to do this, reading the 
| $kernel_src/Documentation/watchdog. 
| 
| Can someone, please, give me a hint?

Don't look in Documentation/* for how to enable config options.

Hint:  Watchdogs are char devices.

Look under Device Drivers, Character devices, Watchdog cards
for Software watchdog, and then enable it.


| This e-mail (and/or attachments) is confidential and may be privileged. Use or disclosure of it by anyone other than a designated addressee is unauthorized. 
| If you are not an intended recipient, please delete this e-mail from the computer on which you received it. We thank you for notifying us immediately. 

Surely.

--
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
