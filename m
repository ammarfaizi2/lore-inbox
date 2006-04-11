Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWDKUii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWDKUii (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWDKUii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:38:38 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:65243 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750933AbWDKUih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:38:37 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christian Heimanns <ch.heimanns@gmx.de>
Subject: Re: Suspend to disk
Date: Tue, 11 Apr 2006 22:38:06 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
References: <443C0C2D.1020207@gmx.de> <200604112235.18943.rjw@sisk.pl>
In-Reply-To: <200604112235.18943.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604112238.07166.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[update]

On Tuesday 11 April 2006 22:35, Rafael J. Wysocki wrote:
> On Tuesday 11 April 2006 22:06, Christian Heimanns wrote:
> > Hello to all,
> > following situation:
> > On my notebook Samsung X20 1730V I'm running Slackware 10.2 current with
> > kernel 2.6.15.6. Suspend to RAM and suspend to disk works fine.
> > Since kernel >= 2.6.16 suspend to disk breaks the restore of the
> > X-Server. That means that the current sessions is lost and the X-Server
> > restarts.
> 
> Does it resume successfully without X (ie. runlevel 3)?
> 
> > No problems with suspend to RAM. Please find attached the 
> > dmesg output for kernel 2.6.15.6 and 2.6.16.2. As well there is the
> > output frpm lspci. The only difference I can find is that I have with
> > kernel 2.6.16 some
> 
> Do you use a framebuffer driver and if so, is it modular?

Sorry, I see in the logs that you do.  Could you please boot with vga=normal
and see if that helps?

Rafael
