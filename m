Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbULMMvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbULMMvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbULMMt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:49:28 -0500
Received: from cantor.suse.de ([195.135.220.2]:8157 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262250AbULMMtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:49:01 -0500
Message-ID: <41BD483B.1000704@suse.de>
Date: Mon, 13 Dec 2004 08:43:55 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
In-Reply-To: <41BCD5F3.80401@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> Just being devils advocate here...
> 
> I had variable Hz in my tree for a while and found there was one 
> solitary purpose to setting Hz to 100; to silence cheap capacitors.

power savings? Having the cpu wake up 1000 times per second if the
machine is idle cannot be better than only waking it up 100 times.

Yes, i am always on the quest for the 5 extra minutes on battery :-)

Stefan

