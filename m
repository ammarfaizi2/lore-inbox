Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUATTnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUATTnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:43:09 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:44787 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265772AbUATTmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:42:49 -0500
Date: Tue, 20 Jan 2004 11:42:38 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [2.6.1-bk2] Might sleep while loading st.ko
Message-ID: <20040120194238.GF23765@srv-lnx2600.matchmail.com>
Mail-Followup-To: Kai Makisara <Kai.Makisara@kolumbus.fi>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20040120000725.GY1748@srv-lnx2600.matchmail.com> <Pine.LNX.4.58.0401202121070.1073@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401202121070.1073@kai.makisara.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 09:30:57PM +0200, Kai Makisara wrote:
> Added linux-scsi which may be better list for this problem.
> 
[snip]
> I thought I used enough debugging options to catch this but I did not...
> 
> The patch below fixes this problem (introduced in 2.6.1) by moving cdev 
> code outside the lock protecting st internal data. The patched driver 
> compiles and seems to work in my tests.
> 
> The sysfs link to /sys/cdev/major/st?m0 is not made any more because I have
> understood that it is a bad idea.
> 
> Thanks for reporting the bug.
> 

I'll put this patch in my next kernel compile.

Thanks.
