Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbUBZSIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUBZSIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:08:05 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:26548 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262911AbUBZSHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:07:24 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 26 Feb 2004 18:07:22 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 RT8139too NIC problems [NOT resolved]
Message-ID: <403E35DA.25412.1F2D6533@localhost>
In-reply-to: <20040226095358.2bb53915@dell_ss3.pdx.osdl.net>
References: <403A6011.5674.103225D9@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The current 2.6.3 driver uses NAPI, and maybe that is related to your troubles.
> 
> What exactly is the hardware config (lspci output)?
> 
> There are debug messages produced, something like:
> 	eth0: Tx queue start entry 0  dirty entry 13
> do you see these in dmesg output? or change your syslog.conf to capture
> debug kernel messages to a different file.
> 
> Also, rebuild with RTL8139_DEBUG defined to pick up more info.
> 
> Seems like interrupts are getting disabled somehow.

Hi Stephen,

I have resolved it short-term re this post:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107765547029938&w=2

regards,

Nick 

-- 
"When you're chewing on life's gristle,
Don't grumble,
Give a whistle
And this'll help things turn out for the best."

