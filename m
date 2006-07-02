Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbWGBJPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWGBJPU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 05:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWGBJPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 05:15:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:17545 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932612AbWGBJPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 05:15:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: Battery-related regression between 2.6.17-git3 and 2.6.17-git6
Date: Sun, 2 Jul 2006 11:15:44 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200607020021.15040.rjw@sisk.pl>
In-Reply-To: <200607020021.15040.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607021115.44739.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 02 July 2006 00:21, Rafael J. Wysocki wrote:
> With the recent -git on my box (Asus L5D, x86_64 SUSE 10) the powersave
> demon is apparently unable to get the battery status, although the data in
> /proc/acpi/battery/BAT0 seem to be correct.  As a result, battery status
> notification via kpowersave doesn't work and it's hard to notice when the
> battery is low/critical.
> 
> So far I have verified that this feature works fine with 2.6.17-git3 and
> doesn't work with 2.6.17-git6 (-git5 doesn't compile here).
> 
> I'll try to get more information tomorrow (unless someone in the know has
> an idea of what's up ;-) ).

I've verified that the problem first appeared in 2.6.17-git4.

Greetings,
Rafael
