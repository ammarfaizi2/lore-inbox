Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWG0VFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWG0VFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWG0VCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:02:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:59925 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWG0VCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:02:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CyVkuuCLAF7dmW5jhMMlTQZTn+katMc0pOHbWiMyYn6zk4fkrgEBwrxdEZTVaibUdooNGudwK4rqN453uBixfguVY2GllRA1EhTDUfsrlylIYOCR6PSNmL0tEIPDK92yWR80gEe96jdHw8TDZvW4aD3OrKI5d1DAOdL7mVYTpW0=
Message-ID: <bd8e30a40607271402g220825a5x1617f6f4a2e14c@mail.gmail.com>
Date: Thu, 27 Jul 2006 14:02:15 -0700
From: "Paul G. Allen" <pgallen@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problems with Digi Etherlite Dirver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While attempting to compile the Digi Etherlite 16/32 driver on a
server running Fedora Core 5 (2.6.17-1.2145_FC5-smp-i686), I ran
across this error:

/usr/src/redhat/BUILD/dgrp-1.9/driver/dgrp_net_ops.c:453: error:
'struct tty_struct' has no member named 'flip'

The driver works in FC3 and FC4. Since I have the source for the
driver, my question is what has changed in the kernel and where do I
look (in the kernel) to find what to change to make the driver
compatible with FC5?

Thanks,

PGA
-- 
Paul G. Allen
Random Logic Consulting
www.randomlogic.com
