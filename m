Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVCNGSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVCNGSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 01:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVCNGSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 01:18:43 -0500
Received: from dialpool1-164.dial.tijd.com ([62.112.10.164]:7569 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S261813AbVCNGSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 01:18:42 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Call for help: list of machines with working S3
Date: Mon, 14 Mar 2005 07:19:00 +0100
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de,
       rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz>
In-Reply-To: <20050214211105.GA12808@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503140719.01536.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 February 2005 22:11, Pavel Machek wrote:
> Hi!
>
> Stefan provided me initial list of machines where S3 works (including
> video). If you have machine that is not on the list, please send me a
> diff. If you have eMachines... I'd like you to try playing with
> vbetool (it worked for me), and if it works for you supplying right
> model numbers.

Acer Travelmate 803LCi, working Suspend to ram:
- Have to use the soft-boot method for the radeon
- Have to shutdown the following parts: 
  * hotplug (actually the USB subsystem, but hotplug does that nicely)
  * ALSA (modem won't work otherwise without reloading the modules)
    (snd_intel8x0m module)
  * MySQL (hinders the actual suspension process and kicks the pc back to 
    where it was)

Other than these little things it works like a charm :)

Jan
-- 
Bumper sticker:
 All the parts falling off this car are of the very finest
 British manufacture.
