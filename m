Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWDXBV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWDXBV4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 21:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWDXBV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 21:21:56 -0400
Received: from rtr.ca ([64.26.128.89]:38835 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751475AbWDXBV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 21:21:56 -0400
Message-ID: <444C2821.5090409@rtr.ca>
Date: Sun, 23 Apr 2006 21:21:37 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Hugh Dickins <hugh@veritas.com>, Chris Ball <cjb@mrao.cam.ac.uk>,
       Pavel Machek <pavel@suse.cz>, Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Garzik <jeff@garzik.org>, Matt Mackall <mpm@selenic.com>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ... (fwd)
References: <Pine.LNX.4.64.0604232153230.2890@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.64.0604232153230.2890@boston.corp.fedex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
> 
..
> May be just me, not matter what I tried, it still doesn't work. Closest 
> I can get is to use "resume=/dev/sda" on boot, able to suspend, able to 
> resume to X windows, can do anything, but can't access disk. ... simple 
> "ls" would hang. Dmesg is show SATA disk timeout.
..

Try Randy Dunlop's libata-acpi patches -- I've been using variants of them
for a *very long time* here now, as they're the only thing that works for me.

Suspend/resume for RAM and DISK both need them.

Cheers
