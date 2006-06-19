Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWFSIQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWFSIQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWFSIQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:16:08 -0400
Received: from 189.Red-80-39-87.staticIP.rima-tde.net ([80.39.87.189]:39309
	"EHLO iquis.com") by vger.kernel.org with ESMTP id S932291AbWFSIQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:16:05 -0400
Message-ID: <44965CC3.1060203@iquis.com>
Date: Mon, 19 Jun 2006 10:13:55 +0200
From: juampe <juampe@iquis.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] USBATM: shutdown open connections when disconnected
References: <OF39174CF7.B508FCBD-ONC125718F.00407FFC-C125718F.00413F4F@telefonica.es>
In-Reply-To: <OF39174CF7.B508FCBD-ONC125718F.00407FFC-C125718F.00413F4F@telefonica.es>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch causes vcc_release_async to be applied to any *open
>** v*cc's when the modem is *disconnected*. 


> Unfortunately this patch may create problems
> for those rare users like me who use routed IP or some other
> non-ppp connection method that goes via the ATM ARP daemon: the
> daemon is buggy, and with this patch will crash when the modem
> is *disconnected*.  Users with a buggy atmarpd can simply restart
> it after disconnecting the modem.

First i must thanks all effort in usbatm development.
IMHO New fatures to a driver that works well and can block the use, 
especially if it can disable internet access and the problem is know,
MUST be disabled by default or provide a mechanism to disable it.

I'm a rare user with routed IP and this patch blocks the normal use of internet
I dont understand how this patch can be accepted for a stable release without 
any kind of disable mechanism.

Yeah, i know that atmarp is buggy, but before speedtouch driver and atm works well during months.

Best Regards.
Juampe.

