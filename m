Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUAWO2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 09:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUAWO2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 09:28:14 -0500
Received: from [81.171.138.7] ([81.171.138.7]:28835 "EHLO
	gateway.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id S262131AbUAWO1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 09:27:51 -0500
Message-ID: <0EBC45FCABFC95428EBFC3A51B368C9501C9C468@jessica.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: linux-kernel@vger.kernel.org
Subject: RE: buggy raid checksumming selection?
Date: Fri, 23 Jan 2004 14:27:32 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
X-herefordshire.gov.uk-MailScanner-Information: Please contact the ISP for more information
X-herefordshire.gov.uk-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jan 23, 2004 at 11:40:53AM -0200, Evaldo Gardenali wrote:
> 
>  > Uhh. correct me if I am wrong, but shouldnt it select the 
> fastest algorithm?
> 
> No, if it can choose a function which avoids polluting the cache over
> one that doesn't, it will.  Even if that means slightly less 
> raw throughput
> 
> This comes up time after time, maybe we need a printk in that case ?
> 
> 	Dave

I'm not suggesting that anyone waste any time over this, but are there any
"real world" benchmarks of the "fastest" vs "non cache-polluting"
algorithms.

Could there be any situations whereby even with cache-pollution we'd get
better performance?

I know it depends on the workload mix and amount of I/O, but...

Just curious.

Phil
---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK
