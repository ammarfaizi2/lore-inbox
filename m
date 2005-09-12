Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVILQdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVILQdW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVILQdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:33:22 -0400
Received: from mxout1.vodatel.hr ([217.14.208.62]:44738 "EHLO
	mxout1.vodatel.hr") by vger.kernel.org with ESMTP id S932068AbVILQdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:33:21 -0400
Message-ID: <4325ADE1.40702@vodatel.hr>
Date: Mon, 12 Sep 2005 18:33:37 +0200
From: Vedran Rodic <vedran@vodatel.hr>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-dvb@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb] 2.6.13 reboot problems (when skystar2 DVB driver
 inserted)
References: <43217233.30206@vodatel.hr>
In-Reply-To: <43217233.30206@vodatel.hr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vedran Rodic wrote:

> Hi
>
> I'm using 2.6.13 on my computer with skystar2, b2c2-flexcop driver.
>
> If the driver is inserted into kernel, the reboot won't work.
>
> It just hangs at "Rebooting..."
>
> Can I get any help in debugging these reboot problems?
>
> I've put dmesg and lspci output at 
> http://gargamel.vodatel.hr/~vedran/kernel/


This issue is now being tracked at



http://bugzilla.kernel.org/show_bug.cgi?id=5228

Summary
dvb_net deadlock in 'ifconfig dvbX_Y down' when more than one dvb_net 
interface is configured
