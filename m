Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUJGVZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUJGVZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268213AbUJGVVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:21:34 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:60861 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267904AbUJGVSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:18:23 -0400
Message-ID: <4165B233.9080405@rtr.ca>
Date: Thu, 07 Oct 2004 17:16:35 -0400
From: Mark Lord <lsml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Mark Lord <lsml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca>
In-Reply-To: <4161A06D.8010601@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a related note..

In the longer term, I'd like Jeff & I to get together and agree
upon some interface changes in libata to make it easier for this
driver (and others) to share more of the code dealing with
the emulation of non-data SCSI commands like INQUIRY and friends.

Right now that's not as easy as it could be, due to the specialized
libata struct parameters required, but I think it could be harmonized.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
