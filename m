Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWBEOgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWBEOgo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 09:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWBEOgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 09:36:44 -0500
Received: from smtp.bredband2.net ([82.209.166.4]:28727 "EHLO
	smtp.bredband2.net") by vger.kernel.org with ESMTP id S1750840AbWBEOgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 09:36:43 -0500
Message-ID: <43E60D64.3020903@home.se>
Date: Sun, 05 Feb 2006 15:36:20 +0100
From: =?ISO-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-netdev@vger.kernel.org
Subject: Problems with de2104x...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As others have reported on lkml ("Bad interaction between uhci_hcd and 
de2104x"), I'm having problems with de2104x driver. I removed usb-ehcd, 
but that alone didn't seem to help (other NICs doesnt work). Not loading 
de2104x does though.

The oops I got without USB can be seen at:

http://sandos.ath.cx/~sandos/de2104x_oops.png

Now, I dont even use this NIC, and I probably wont for some time or 
ever, considering its 10Mbit or something. I only have it to have a 
spare port "incase I need it", which I havent yet =).

If anyone feels like debugging this though, feel free to tell me what to 
provide in the way of info etc. and Ill try to help.

---
John Bäckstrand
