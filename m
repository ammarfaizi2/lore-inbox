Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756723AbWKVTgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723AbWKVTgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbWKVTgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:36:38 -0500
Received: from mx0.towertech.it ([213.215.222.73]:46735 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1756723AbWKVTgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:36:37 -0500
Date: Wed, 22 Nov 2006 20:36:33 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
       Kumar Gala <galak@kernel.crashing.org>,
       Kim Phillips <kim.phillips@freescale.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, akpm@osdl.org, davem@davemloft.net,
       kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org,
       ralf@linux-mips.org, rmk@arm.linux.org.uk
Subject: NTP time sync
Message-ID: <20061122203633.611acaa8@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 wrto the in-kernel NTP synchronization,
 as discussed before [1], my opinion
 is that it should be done in userland.

 Keeping it in kernel implies subtle code
 in each of the supported architectures.

 So, if the arch maintainers agree, 
 I would suggest to schedule it for removal.

[1] http://lkml.org/lkml/2006/3/28/358


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

