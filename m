Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUIUSAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUIUSAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUIUSAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:00:10 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:2723 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267916AbUIUSAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:00:06 -0400
Message-ID: <41506BBE.2050507@rtr.ca>
Date: Tue, 21 Sep 2004 13:58:22 -0400
From: Mark Lord <lsml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID v.96 for 2.6.9-rc2
References: <4150666A.90807@rtr.ca>
In-Reply-To: <4150666A.90807@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I missed one thing in the proof read.. these two lines (below)
will be added to qstor.c, for use by the separate RAID management module.

    EXPORT_SYMBOL(qs_del_raid);
    EXPORT_SYMBOL(qs_setup_raid);

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
