Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWJKLa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWJKLa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 07:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWJKLa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 07:30:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54033 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030349AbWJKLaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 07:30:55 -0400
Date: Wed, 11 Oct 2006 11:30:42 +0000
From: Pavel Machek <pavel@ucw.cz>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [PATCH] Add support for the generic backlight device to the IBM ACPI driver
Message-ID: <20061011113042.GA4725@ucw.cz>
References: <20061009113235.GA4444@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009113235.GA4444@homac.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add support for the generic backlight interface below
> /sys/class/backlight. The patch keeps the procfs brightness handling for
> backward compatibility. For this to archive, the patch adds two generic
> functions brightness_get and brightness_set to be used both by the procfs
> related and the sysfs related methods.
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>

Looks okay to me. It would be nice to get this in, so that we teach
people to use generic interface, and so that we can remove crappy
interfaces in future...

-- 
Thanks for all the (sleeping) penguins.
