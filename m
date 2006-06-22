Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWFVIYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWFVIYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWFVIYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:24:55 -0400
Received: from gw.goop.org ([64.81.55.164]:41100 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751131AbWFVIYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:24:54 -0400
Message-ID: <449A53DC.5090306@goop.org>
Date: Thu, 22 Jun 2006 01:25:00 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org, stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
References: <20060621034857.35cfe36f.akpm@osdl.org>	<4499BE99.6010508@gmail.com>	<20060621221445.GB3798@inferi.kami.home>	<20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org>
In-Reply-To: <20060622004648.f1912e34.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> My laptop has the same problem.
>   
Mine too.  I wonder if its related to the (apparently) bluetooth-caused 
oops I reported earlier today?

Though I'm seeing the suspend problem on a system with no bluetooth 
module loaded; the only USB device on the bus is the fingerprint-reader.

My suspend script removes the uhci_hcd module on suspend.  The device 
complaining EBUSY is the ehci hub, which has nothing hanging off it.

    J
