Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751922AbWAOMlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWAOMlS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWAOMlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:41:18 -0500
Received: from natblindhugh.rzone.de ([81.169.145.175]:59889 "EHLO
	natblindhugh.rzone.de") by vger.kernel.org with ESMTP
	id S1751918AbWAOMlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:41:17 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: wireless: recap of current issues (configuration)
Date: Sun, 15 Jan 2006 13:40:10 +0100
User-Agent: KMail/1.8
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost>
In-Reply-To: <1137191522.2520.63.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601151340.10730.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag 13 Januar 2006 23:32 schrieb Johannes Berg:

> [Changing mode of virtual devices]
>
> IMHO there's not much point in allowing changes. I have a feeling that
> might create icky issues you don't want to have to tackle when the
> solution is easy by just not allowing it. Part of my thinking is that
> different virtual types have different structures associated, so
> changing it needs re-creating structures anyway. And different virtual
> device types might even be provided by different kernel modules so you
> don't carry around AP mode if you don't need it.

Even though it is a bit more work on kernel side, we should allow changing the 
mode of virtual devices. Let's face it, even though we find multi-BSS 
capabilities very interesting, 999 of 1000 users won't care due to the two 
facts that IPW firmware IMHO doesn't allow it and virtual interfaces are 
limited to one channel anyway. These users rightfully expect to have one 
interface and be able to do all configurations on it.

Stefan
