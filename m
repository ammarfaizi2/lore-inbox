Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbTIOHnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 03:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbTIOHnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 03:43:49 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:24738 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261218AbTIOHns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 03:43:48 -0400
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: davidsen@tmr.com, zwane@linuxpower.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309150632.h8F6WnHb000589@81-2-122-30.bradfords.org.uk>
References: <200309150632.h8F6WnHb000589@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063611650.2674.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 15 Sep 2003 08:40:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-15 at 07:32, John Bradford wrote:
> That's a non-issue.  300 bytes matters a lot on some systems.  The
> fact that there are drivers that are bloated is nothing to do with
> it.

Its kind of irrelevant when by saying "Athlon" you've added 128 byte
alignment to all the cache friendly structure padding. There are systems
where memory matters, but spending a week chasing 300 bytes when you can
knock out 50K is a waste of everyones time. Do the 40K problems first

