Return-Path: <linux-kernel-owner+w=401wt.eu-S965039AbXAJTZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbXAJTZx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 14:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbXAJTZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 14:25:53 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40412 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965039AbXAJTZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 14:25:53 -0500
Message-ID: <45A53DC7.9080300@drzeus.cx>
Date: Wed, 10 Jan 2007 20:25:59 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/4] Add MMC Password Protection (lock/unlock) support
 V9: mmc_sysfs.diff
References: <4582F007.7030100@indt.org.br> <459B9C4E.3020406@indt.org.br> <45A021B2.4090104@drzeus.cx> <45A4ECDF.8090707@indt.org.br>
In-Reply-To: <45A4ECDF.8090707@indt.org.br>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
>> There's also no handling for an invalid string written to the sysfs node.
>>     
>
> Is this really needed? I thought the function just ignored other values sent to itself that were not handled.
>
>   

Well, returning an error on invalid data is the right<tm> thing to do.
And the warning about mmc_key is caused by this lack of error handling.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

