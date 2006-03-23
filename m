Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWCWNwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWCWNwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWCWNwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:52:45 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:39346 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932077AbWCWNwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:52:44 -0500
Message-ID: <4422A823.1020409@garzik.org>
Date: Thu, 23 Mar 2006 08:52:35 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@cyclades.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make libata not powerdown drivers on PM_EVENT_FREEZE.
References: <200603232151.47346.ncunningham@cyclades.com> <20060323130919.GZ4285@suse.de> <200603232322.23852.ncunningham@cyclades.com>
In-Reply-To: <200603232322.23852.ncunningham@cyclades.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> At the moment libata doesn't pass pm_message_t down ata_device_suspend.
> This causes drives to be powered down when we just want a freeze,
> causing unnecessary wear and tear. This patch gets pm_message_t passed
> down so that it can be used to determine whether to power down the
> drive.
> 
> Prepared against git at the time of writing. Please apply.
> 
> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

I'll put this into the queue for review.

As the top of each source file requests, please CC 
linux-ide@vger.kernel.org and myself on libata changes.

	Jeff



