Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTKFKvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 05:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTKFKvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 05:51:42 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:31760 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263518AbTKFKvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 05:51:41 -0500
Date: Thu, 6 Nov 2003 10:51:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Message-ID: <20031106105140.A15912@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B060ED62@AVEXCH02.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B179AE41C1147041AA1121F44614F0B060ED62@AVEXCH02.qlogic.org>; from andrew.vasquez@qlogic.com on Tue, Nov 04, 2003 at 05:15:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More comments:

 - qla_vendor.c is still unused and should be killed
 - your ioctl API gets worse and worse.  You don't expect this huge
   dungpile of ioctls all marked _BAD to be merged, do you?
   Also having different ioctl values for different plattforms is
   not an option for Linux.
