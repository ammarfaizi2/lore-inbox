Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933709AbWKQQlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933709AbWKQQlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933720AbWKQQlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:41:22 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:26774 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S933709AbWKQQlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:41:21 -0500
Message-ID: <455DE639.6080308@drzeus.cx>
Date: Fri, 17 Nov 2006 17:41:29 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org, ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: Re: [patch 1/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
References: <455DB297.1040009@indt.org.br> <20061117160951.GD28514@flint.arm.linux.org.uk>
In-Reply-To: <20061117160951.GD28514@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Nov 17, 2006 at 09:01:11AM -0400, Anderson Briglia wrote:
>   
>>  #define MMC_CAP_BYTEBLOCK	(1 << 2)	/* Can do non-log2 block 
>>  sizes */
>> +#define MMC_CAP_LOCK_UNLOCK	(1 << 3)	/* Host password support 
>> capability */
>>     
>
> What's the point of this capability.  If the host can do BYTEBLOCK transfers
> it can send the password commands.
>
>   

This has been pointed out in the past. Anderson, please make sure you
address all the previous concerns before sending out a new patch set.
This just creates extra work for us.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

