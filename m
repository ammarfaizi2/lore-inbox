Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422630AbWCWWpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWCWWpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWCWWpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:45:16 -0500
Received: from rtr.ca ([64.26.128.89]:65249 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1422630AbWCWWpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:45:14 -0500
Message-ID: <442324F8.6050603@rtr.ca>
Date: Thu, 23 Mar 2006 17:45:12 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Jeff Garzik <jeff@garzik.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make libata not powerdown drivers on PM_EVENT_FREEZE.
References: <200603232151.47346.ncunningham@cyclades.com> <200603232322.23852.ncunningham@cyclades.com> <4422A823.1020409@garzik.org> <200603240701.06739.ncunningham@cyclades.com>
In-Reply-To: <200603240701.06739.ncunningham@cyclades.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Thursday 23 March 2006 23:52, Jeff Garzik wrote:
>> Nigel Cunningham wrote:
>>> Hi.
>>>
>>> At the moment libata doesn't pass pm_message_t down ata_device_suspend.
>>> This causes drives to be powered down when we just want a freeze,
>>> causing unnecessary wear and tear. This patch gets pm_message_t passed
>>> down so that it can be used to determine whether to power down the
>>> drive.
>>>
>>> Prepared against git at the time of writing. Please apply.
>>>
>>> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

Works very well here for me, and long overdue it was!

Thanks, Nigel!
