Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVHKABa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVHKABa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbVHKABa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:01:30 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18169 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964842AbVHKABa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:01:30 -0400
Date: Wed, 10 Aug 2005 18:00:37 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: how do I read CPU temperature in ACPI? (w/ P5WD2 motherboard)
In-reply-to: <4A6sY-4zI-27@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42FA9525.7020603@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4A6sY-4zI-27@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Madore wrote:
> Hi.  I apologize for what is surely a stupid question: I understand
> that ACPI should be able to tell me what my CPU's temperature is (I
> have a sever overheating problem and I am trying to solve it by
> underclocking somewhat, but I need to be able to read the temperature
> to do anything worth while), but no matter what ACPI modules I load, I
> can't find any hint of a CPU temperature reading anywhere below
> /proc/acpi (the /proc/acpi/thermal_zone/ directory, for example,
> remains empty).

Presumably your motherboard/BIOS doesn't export the temperature as an 
ACPI thermal zone. This isn't required..

Likely your best bet is lm_sensors if your board has a sensor chip that 
it supports..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

