Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbUKDTgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUKDTgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbUKDTdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:33:36 -0500
Received: from msgbas1tx.cos.agilent.com ([192.25.240.37]:11714 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S262427AbUKDT3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:29:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: QM_MODULES not implemented in 2.6.9
Date: Thu, 4 Nov 2004 11:29:17 -0800
Message-ID: <08A354A3A9CCA24F9EE9BE13600CFBC50F85B5@wcosmb07.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: QM_MODULES not implemented in 2.6.9
thread-index: AcTCoZuR5N1QjyT6Qh6GbiNHZ/kBTAAAsbXQ
From: <yiding_wang@agilent.com>
To: <rddunlap@osdl.org>, <yiding_wang@agilent.com>, <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Nov 2004 19:29:18.0258 (UTC) FILETIME=[93C19920:01C4C2A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks all! I thought 2.6.9 has populated that support already. 

-----Original Message-----
From: Randy.Dunlap [mailto:rddunlap@osdl.org]
Sent: Thursday, November 04, 2004 10:57 AM
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org; Yidng_wang@agilent.com
Subject: Re: QM_MODULES not implemented in 2.6.9


yiding_wang@agilent.com wrote:
> I noticed that this issue was there before but thought it was being taken care of since my Linux-2.6.2 kernel did not complain. Now I loaded Linux-2.6.9 and this QM_MODULES Function not implemented error pops up whenever I run module related command.
> 
> If I need update module patch, could someone tell which module patch I should apply? If something else is wrong, please advice. The kernel is configured to support module.

You need to use module-init-tools that are made for 2.6.x kernels.
They can be found here:
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
and are often already part of most current Linux distros.

-- 
~Randy
