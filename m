Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVBKP33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVBKP33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 10:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVBKP33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 10:29:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:41088 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262158AbVBKP3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 10:29:24 -0500
Subject: Re: aacraid fails under kernel 2.6
From: Mark Haverkamp <markh@osdl.org>
To: Jonathan Knight <jonathan@cs.keele.ac.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Mark Salyzyn <mark_salyzyn@adaptec.com>
In-Reply-To: <E1Czbmu-0006yr-00@nina.cs.keele.ac.uk>
References: <E1Czbmu-0006yr-00@nina.cs.keele.ac.uk>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 07:29:11 -0800
Message-Id: <1108135751.10361.6.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 14:28 +0000, Jonathan Knight wrote:
> 
> We are having major problems with the aacraid module under fedora core 2 on
> Dell poweredge 2500.  These use PERC3/Di controllers.

[ ... ]

> 
> The systems run fine with no users, but as soon as the disks go under load
> we get the following:
> 
> Feb 10 08:20:56 romeo kernel: aacraid: Host adapter reset request. SCSI hang ?
> Feb 10 08:21:56 romeo kernel: aacraid: SCSI bus appears hung
> Feb 10 08:21:56 romeo kernel: scsi: Device offlined - not ready after error recovery: host 2 channel 0 id 0 lun 0
> Feb 10 08:21:56 romeo kernel: SCSI error : <2 0 0 0> return code = 0x6000000
> Feb 10 08:21:56 romeo kernel: end_request: I/O error, dev sdc, sector 296582775
> Feb 10 08:21:56 romeo kernel: scsi2 (0:0): rejecting I/O to offline device
> Feb 10 08:21:56 romeo last message repeated 4 times
> Feb 10 08:21:56 romeo kernel: Buffer I/O error on device sdc1, logical block 33660323
> Feb 10 08:21:56 romeo kernel: scsi2 (0:0): rejecting I/O to offline device
> Feb 10 08:21:56 romeo kernel: Buffer I/O error on device sdc1, logical block 33660323
> ....and so on.
> 
> 
> Careful rebooting shows nothing untoward on the raid array and the system
> will start with no problems.
> 

[ ... ]

A number of people have seen problems like this going from 2.4 to 2.6.
Mark Salyzyn from Adaptec has suggested in those cases to make sure that
the board firmware is up to date.  I've copied Mark on this mail.

Mark.

> 
-- 
Mark Haverkamp <markh@osdl.org>

