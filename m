Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932929AbWK0SpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbWK0SpV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933046AbWK0SpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:45:21 -0500
Received: from mgw-ext14.nokia.com ([131.228.20.173]:52048 "EHLO
	mgw-ext14.nokia.com") by vger.kernel.org with ESMTP id S932929AbWK0SpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:45:20 -0500
Message-ID: <456ACC9E.2030105@indt.org.br>
Date: Mon, 27 Nov 2006 07:31:42 -0400
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
References: <45646457.1060203@indt.org.br> <45680555.1000406@drzeus.cx>
In-Reply-To: <45680555.1000406@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2006 11:27:53.0805 (UTC) FILETIME=[145597D0:01C71217]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061127132955-0C9B7BB0-7A8BBEAA/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

ext Pierre Ossman wrote:
> Patch looks ok. But I never got an answer what the difference between
> "change" and "assign" is.

You're right, the command is the same, but the difference is the password's
length and password itself sent to the card.
According to MMC spec 4.1, when a password replacement is done, the length value
(PWD_LEN) shall include both passwords, the old and the new one, and the password
(PWD) shall include the old (currently) followed by the new password.

Best Regards,

Anderson Briglia
