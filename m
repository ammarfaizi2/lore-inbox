Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTIOM3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbTIOM3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:29:34 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:24961 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261311AbTIOM3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 08:29:33 -0400
Date: Mon, 15 Sep 2003 13:43:08 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309151243.h8FCh8ne001294@81-2-122-30.bradfords.org.uk>
To: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Cc: john@grabjohn.com, linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I still like the idea of a single config variable to remove all special
> case code for non-configured CPUs, call it NO_BLOAT or MINIMALIST_KERNEL
> or EMBEDDED_HELPER as you will. The embedded folks would then have a good
> handle to do the work and identify sections to be so identified.

Removing the code for non-configured CPUs should be the default.  It's
common sense - if you configure a kernel to support Athlons only, why
have PIV workarounds in there, unless you're actually debugging a
kernel problem?

John.
