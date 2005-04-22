Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVDVBUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVDVBUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 21:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVDVBUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 21:20:35 -0400
Received: from outbound01.telus.net ([199.185.220.220]:21491 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S261906AbVDVBUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 21:20:30 -0400
Subject: Re: Linux 2.6.12-rc3:microtek.c:338: error: for each function it
	appears in.
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 19:20:09 -0600
Message-Id: <1114132809.7700.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.  I downloaded, patched and started the build.  Basically everything
stops when I get a "microtek.c:338: error: `FAILURE' undeclared" error
(the build keeps trying, but no modules get created).  
I suspect others may have the same problem, but feel free to e-mail me
for more information (and you will have to as I am not on the list).
...ok, also I have tried adding 
     #define MTS_SCSI_ERR_MASK ~0x3fu
---->#define FAILURE           ~0x3fu
on line 55 of microtek.h ...basically a copycat of the previous error
line...(but I suspect the kernel maintainer would be a better person to
define FAILURE somewhere...)
And...it does boot and I can
<cough>taint.the.kernel.with.nvidia.video<cough>

TIA,
Bob
-- 
Bob Gill <gillb4@telusplanet.net>

