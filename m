Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVABLXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVABLXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 06:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVABLXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 06:23:08 -0500
Received: from mailgate1.uni-kl.de ([131.246.120.5]:42728 "EHLO
	mailgate1.uni-kl.de") by vger.kernel.org with ESMTP id S261157AbVABLXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 06:23:04 -0500
Date: Sun, 2 Jan 2005 00:41:11 +0100
From: Eduard Bloch <edi@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050101234111.GA27099@zombie.inka.de>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <1104269125.21123.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1104269125.21123.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Håkan Lindqvist [Tue, Dec 28 2004, 10:25:25PM]:

> > ifplugd can see the link status change when i plug and unplug the cable,
> > but the dhclient it runs just tries and retries to get an ip without
> > success.
> 
> 
> I seem to get the same problem on my IBM Thinkpad X31.
> 
> At least e100 and snd-intel8x0 break down that way on suspend/resume.
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=110419612421765&w=2)

Similar with USB on Toshiba Satellite Pro 2100. After resume, the
hardware simply does not work - the driver loads, but no USB input event
does ever reach the userspace. Reloading all USB drivers does not help.

0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42)

Regards,
Eduard.
-- 
  "After watching my newly-retired dad spend two weeks learning how to
  make a new folder, it became obvious that "intuitive" mostly means
  "what the writer or speaker of intuitive likes".
- Bruce Ediger, bediger@teal.csn.org, on X the intuitiveness of a Mac interface
