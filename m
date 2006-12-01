Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161734AbWLAVQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161734AbWLAVQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161748AbWLAVQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:16:05 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:18328 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1161734AbWLAVQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:16:02 -0500
Message-ID: <45709B95.9000009@drzeus.cx>
Date: Fri, 01 Dec 2006 22:16:05 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
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
References: <45646457.1060203@indt.org.br> <45680555.1000406@drzeus.cx> <456ACC9E.2030105@indt.org.br>
In-Reply-To: <456ACC9E.2030105@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> Hi Pierre,
>
> ext Pierre Ossman wrote:
>> Patch looks ok. But I never got an answer what the difference between
>> "change" and "assign" is.
>
> You're right, the command is the same, but the difference is the
> password's
> length and password itself sent to the card.
> According to MMC spec 4.1, when a password replacement is done, the
> length value
> (PWD_LEN) shall include both passwords, the old and the new one, and
> the password
> (PWD) shall include the old (currently) followed by the new password.

So shouldn't this be something that userspace handles?

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

