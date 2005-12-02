Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVLBVPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVLBVPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVLBVPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:15:21 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:16059 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750774AbVLBVPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:15:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ben Greear <greearb@candelatech.com>
Subject: Re: Keyboard broken in 2.6.13.2
Date: Fri, 2 Dec 2005 16:15:15 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <43909451.20105@candelatech.com>
In-Reply-To: <43909451.20105@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512021615.16247.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 December 2005 13:37, Ben Greear wrote:
> I have a system with a super-micro P8SCI motherboard.
> 
> The default FC2 kernel (2.6.10-1.771_FC2smp) works fine, but
> when I try to boot a 2.6.13.2 kernel, I see this error:
> 
> i8042.c: Can't read CTR while initializing i8042
> 
> If I hit the keyboard early in the boot, the system will just reboot.
> 
> If I wait a bit, then it will boot to a prompt, but no keyboard input
> is accepted.
>

Does booting with "usb-handoff" boot option help any? 

-- 
Dmitry
