Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269056AbUI3HCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269056AbUI3HCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 03:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUI3HCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 03:02:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12722 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269056AbUI3HCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 03:02:07 -0400
Date: Thu, 30 Sep 2004 08:59:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/1] Per-priority statistics for CFQ w/iopriorities 2.6.8.1
Message-ID: <20040930065917.GA2288@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missed this patch the first time over (thank you lwn :-) - why are you
using atomic counters? In all the paths you set them, you already have
the queue lock.

-- 
Jens Axboe

