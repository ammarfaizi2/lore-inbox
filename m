Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUIUSVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUIUSVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267945AbUIUSVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:21:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34247 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267943AbUIUSVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:21:48 -0400
Message-ID: <4150712F.3080504@pobox.com>
Date: Tue, 21 Sep 2004 14:21:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lsml@rtr.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID v.96 for 2.6.9-rc2
References: <4150666A.90807@rtr.ca> <41506BBE.2050507@rtr.ca>
In-Reply-To: <41506BBE.2050507@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Okay, I missed one thing in the proof read.. these two lines (below)
> will be added to qstor.c, for use by the separate RAID management module.
> 
>    EXPORT_SYMBOL(qs_del_raid);
>    EXPORT_SYMBOL(qs_setup_raid);


Where is this seperate RAID management module?  :)

Typically we do not add kernel hooks to non-public stuff...

	Jeff


