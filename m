Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbUDEBe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 21:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUDEBe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 21:34:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26295 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263004AbUDEBeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 21:34:25 -0400
Message-ID: <4070B794.2070907@pobox.com>
Date: Sun, 04 Apr 2004 21:34:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dieter Stueken <stueken@conterra.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata transport attributes
References: <40702492.8050603@conterra.de>
In-Reply-To: <40702492.8050603@conterra.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Stueken wrote:
> Jeff Garzik wrote:
> 
>> Since libata is leaving SCSI in 2.7, I would rather not add 
>> superfluous stuff like this at all.
>> Further, you can already retrieve the information you export with 
>> _zero_ new code.
> 
> 
> does this include informations about the drives SMART status, too?

No.  SMART would not be appropriate for a transport attribute either.


> The smartmotools (http://smartmontools.sourceforge.net/) won't work
> with libata until some "passthrough" command gets implemented :-(
> Will this be available soon (or even working now), or do I have to
> wait until 2.7?

Soon.

	Jeff



