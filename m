Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVECTAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVECTAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 15:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVECTAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 15:00:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:43497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261592AbVECTAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 15:00:11 -0400
Date: Tue, 3 May 2005 12:00:05 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy <genanr@emsphone.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: WARNING : kernel 2.6.11.7 (others) kills megaraid 4e/Si dead
Message-ID: <20050503190005.GS23013@shell0.pdx.osdl.net>
References: <20050503151532.GA1316@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503151532.GA1316@thumper2>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy (genanr@emsphone.com) wrote:
> cross posted due to the severity of this issue.
> 
> I have killed two Dell 1850 (x86_64) with megaraid 4e/SI servers using
> kernel 2.6.11.7.  When the system boots, it looks like it does not see the
> megaraid controller (because it never prints anything about it) and hangs
> when it tries to mount root.  When rebooted, the system says no firmware
> present for embedded raid controller.  I then try to flash it, the flash
> program says the firmware is corrupt and flashes the controller.  However,
> upon reboot I still get the no firmware present, thus the machine can no
> longer boot off the raid.

Not good.  There were no megaraid changes in the -stable series.  What's
the last kernel.org kernel that worked for you?

thanks,
-chris
