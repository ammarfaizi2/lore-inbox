Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUEVSCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUEVSCo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 14:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUEVSCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 14:02:43 -0400
Received: from hadar.amcc.com ([192.195.69.168]:51401 "EHLO hadar.amcc.com")
	by vger.kernel.org with ESMTP id S261711AbUEVSCk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 14:02:40 -0400
From: "Adam Radford" <aradford@amcc.com>
To: hch@infradead.org, Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: RE: 2.6.6-mm5
Date: Sat, 22 May 2004 11:02:18 -0700
Organization: AMCC
X-Sent-Folder-Path: Sent Items
X-Mailer: Oracle Connector for Outlook 9.0.4 51114 (9.0.6627)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-ID: <HY4NGC01.77W@hadar.amcc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hch,

I did try to CC linux-scsi in the original email for the 3ware driver submission/review,
and 2 emails since then.  None of them went through (no bounce message either).  

Does anybody know what the max email size is?  Is it < 145k?

--
Adam Radford
Staff Software Engineer
AMCC

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org]On Behalf Of hch@infradead.org
Sent: Saturday, May 22, 2004 2:23 AM
To: Jeff Garzik
Cc: Andrew Morton; linux-kernel@vger.kernel.org; SCSI Mailing List
Subject: Re: 2.6.6-mm5


On Sat, May 22, 2004 at 05:09:59AM -0400, Jeff Garzik wrote:
> Andrew Morton wrote:
> >- Added a new SATA RAID driver from 3ware.  From a quick peek it seem to
> >  need a little work yet.
> 
> 
> It's not too bad... but it looks more like a 2.2 driver forward ported 
> to 2.4, than a 2.6.x driver.  Needs some luvin' from the 2.6 scsi api crew.
> 
> Overall, it appears to be a message-based firmware engine like 
> drivers/block/carmel.c, that hides the SATA details in the firmware.

In addition driver submission should always go through linux-scsi.  Please
tell them to submit it to linux-scsi so we can have a public review process
there.
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

