Return-Path: <linux-kernel-owner+w=401wt.eu-S964778AbXALREw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbXALREw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbXALREw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:04:52 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:59124 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964778AbXALREv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:04:51 -0500
Message-ID: <45A7BFB0.9090308@garzik.org>
Date: Fri, 12 Jan 2007 12:04:48 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Soeren Sonnenburg <kernel@nn7.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA hotplug from the user side ?
References: <1168588629.5403.7.camel@localhost>
In-Reply-To: <1168588629.5403.7.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg wrote:
> Dear all,
> 
> I'd like to try out SATA hotplugging using a SIL3114. Though I was
> harvesting the web, I could not find any useful information how this is
> done in practice.
> 
> Well I realized that I can still use scsiadd to print and remove
> devices, e.g.:

For SIL3114, you shouldn't have to run any commands at all.  It should 
notice when you yank the cable, or plug in a new device.

	Jeff



