Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTJHPgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTJHPgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:36:18 -0400
Received: from mail.convergence.de ([212.84.236.4]:65511 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261681AbTJHPgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:36:17 -0400
Message-ID: <3F842EEE.5070001@convergence.de>
Date: Wed, 08 Oct 2003 17:36:14 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/14] firmware update for av7110 dvb driver
References: <10656197272107@convergence.de> <1065624307.5470.242.camel@pegasus>
In-Reply-To: <1065624307.5470.242.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcel,

>>... send to Linus only. (You don't want a 150kB bzip2 compressed firmware blob, don't you? In case you do, drop me a line.)

> the request_firmware() framework is part of Linux 2.4 and 2.6 and so for
> most drivers the firmware file can be loaded from userspace through proc
> or sysfs. Please take a look at it.

Yes, we know. When I looked at it the last time, there were some 
problems that kept us from actually finishing the work.

(If you did not use a hotplug agent, then the system was frozen, because 
the firmware foo did not use it's own workqueue)

I gave some feedback, but I don't know if the fixes made it into the 
kernel yet.

I have once patched our drivers to use request_firmware() and I have 
these patches still lying around, so I'll try and see if they work when 
I have some spare time.

> Regards
> Marcel

CU
Michael.

