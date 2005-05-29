Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVE2Ulz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVE2Ulz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 16:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVE2Ulz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 16:41:55 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:9194 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S261432AbVE2Ulx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 16:41:53 -0400
Message-ID: <429A2904.8040500@sh.cvut.cz>
Date: Sun, 29 May 2005 22:41:40 +0200
From: Rudolf Marek <r.marek@sh.cvut.cz>
Reply-To: lm-sensors@lm-sensors.org
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [lm-sensors] SMSC LPC47M192 - "Device is disabled, will not use"
References: <429A1930.6040409@gmail.com>
In-Reply-To: <429A1930.6040409@gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
> In the dmesg output it says:
> 
> smsc47m1: Found SMSC LPC47M15x/LPC47M192
> smsc47m1: Device is disabled, will not use
> 
> What does this mean? How do I get this chip to tell me fan speed and CPU
> temperature (if that's even what it does?)?

It means that the logical device is disabled and it most cases it means that this chip is not used for hw. monitoring.
Please can you tell us your motherboard brand and model?
Also please run sensors-detect script include whole output in your next email.
Tell us what version of kernel and lm_sensors you use.

We can try to forcibly enable in future.

Thanks

Regards

Rudolf


