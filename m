Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937007AbWLDQNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937007AbWLDQNS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937057AbWLDQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:13:18 -0500
Received: from smtp.nokia.com ([131.228.20.170]:32807 "EHLO
	mgw-ext11.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937007AbWLDQNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:13:17 -0500
Message-ID: <457449CD.3040108@indt.org.br>
Date: Mon, 04 Dec 2006 12:16:13 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
CC: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 4/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_sysfs.diff
References: <45646457.1060203@indt.org.br> <45680555.1000406@drzeus.cx> <456ACC9E.2030105@indt.org.br> <45709B95.9000009@drzeus.cx>
In-Reply-To: <45709B95.9000009@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2006 16:11:59.0849 (UTC) FILETIME=[ED75BD90:01C717BE]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext Pierre Ossman wrote:
> Anderson Briglia wrote:
>> Hi Pierre,
>>
>> ext Pierre Ossman wrote:
>>> Patch looks ok. But I never got an answer what the difference between
>>> "change" and "assign" is.
>> You're right, the command is the same, but the difference is the
>> password's
>> length and password itself sent to the card.
>> According to MMC spec 4.1, when a password replacement is done, the
>> length value
>> (PWD_LEN) shall include both passwords, the old and the new one, and
>> the password
>> (PWD) shall include the old (currently) followed by the new password.
> 
> So shouldn't this be something that userspace handles?
> 

I merged the code for "change" and "assign". But the action (returned from kernel
to user space application continues as "change" and "assign" separately.

Anderson Briglia
