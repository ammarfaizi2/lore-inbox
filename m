Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTI0X2P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 19:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTI0X2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 19:28:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11685 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262251AbTI0X2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 19:28:14 -0400
Message-ID: <3F761D02.3050708@pobox.com>
Date: Sat, 27 Sep 2003 19:28:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Broadcom BCM5901 NIC
References: <20030927231904.GA22769@hardeman.nu>
In-Reply-To: <20030927231904.GA22769@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman wrote:
> Hi,
> 
> my new laptop (IBM Thinkpad G40) has an integrated NIC made by broadcom. 
> It's a BCM5901 card for which support was added in the tg3 driver a few 
> weeks ago (both in 2.4 and 2.6-test). However, the device doesn't work, 
> it insmods just fine and claims the hardware, but the machine never 
> responds to ping messages and the led indicating network activity is 
> never activated.
> 
> Broadcom has released a driver of their own (bcm5700) which works with 
> kernel 2.4.21. When I try that combination it works fine, however, the 
> bcm5700 driver wont work at all on recent 2.4 or 2.6 kernels.
> 
> Does anyone know what is wrong with the tg3 driver? Has anyone tried 
> using it on a 5901 card with success?


Trying unplugging/plugging the cable, or ifdown+ifup cycle, and let me 
know if that fixes things.

	Jeff



