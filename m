Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVACHAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVACHAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 02:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVACHAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 02:00:40 -0500
Received: from main.gmane.org ([80.91.229.2]:3741 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261403AbVACHAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 02:00:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: Re: cpu throttling powernow-k8 and acpi in kernel
Date: Mon, 03 Jan 2005 08:02:40 +0100
Message-ID: <41D8EE10.3040003@gmx.net>
References: <41D80CAB.1060903@gmx.net> <Pine.LNX.4.60.0501022349340.4725@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 83.215.48.11
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.60.0501022349340.4725@poirot.grange>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> skipped...
> 
> Try writing to sensors@stimpy.netroedge.com. I had a CPU-throttling 
> problem, when the CPU got throttled down without really getting hot - I 
> just had wrongly configured /etc/sensors.conf. Might be your problem too?

Would be happy if it were the sensors but i am not using them, a least 
not the ones lm-sensors can use. My temperature is shown via ACPI 
Thermal zone of the processor driver. Afaik ACPI does also regulate the 
fan-speed so it doesn't work proper without acpi-processor driver as 
mentionend in the first post. so i don't think that the different 
sensors in i2c have to do something with it. But thanks for response, 
good to know that others have similar problems, even if they are not the 
same ;) Anyone else an idea how to tell acpi that it has perhaps wrong 
values?. I remember that when i first used this laptop with linux the 
fan went off after some time but now the fan doesn't go off, at least i 
don't recognize it. this is just because acpi has too high temps and 
lets the fan cool down the cpu because of that (at least acpi thinks so 
;)). Thanks for every help


Georg Schild

