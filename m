Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWF0Sn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWF0Sn6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWF0Sn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:43:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48275 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750967AbWF0Sn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:43:57 -0400
Subject: Re: [PATCH] watchdog: add pretimeout ioctl
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Wim Van Sebroeck <wim@iguana.be>
In-Reply-To: <20060627182225.GD10805@localdomain>
References: <20060627182225.GD10805@localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Jun 2006 19:59:45 +0100
Message-Id: <1151434785.32186.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-27 am 13:22 -0500, ysgrifennodd minyard@acm.org:
> Some watchdog timers support the concept of a "pretimeout" which
> occurs some time before the real timeout.  The pretimeout can
> be delivered via an interrupt or NMI and can be used to panic
> the system when it occurs (so you get useful information instead
> of a blind reboot).

All watchdogs can do pre-timeouts in software so possibly this should
use a software fallback as well if you want good coverage ?

