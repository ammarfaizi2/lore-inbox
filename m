Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269646AbUJGVwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269646AbUJGVwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUJGVvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:51:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35771 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268080AbUJGVqM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:46:12 -0400
Message-ID: <4165B914.7030507@pobox.com>
Date: Thu, 07 Oct 2004 17:45:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lsml@rtr.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <4165B233.9080405@rtr.ca>
In-Reply-To: <4165B233.9080405@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As another example, a piece of code that implements the HDIO_xxx ioctls 
in terms of a SCSI command can be quite generic, and separate from the 
libata driver API, while still in libata.

	Jeff



