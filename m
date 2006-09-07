Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbWIGXjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWIGXjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbWIGXjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:39:54 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:26517 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751733AbWIGXjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:39:53 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 8 Sep 2006 01:38:53 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 0/2] ieee1394: sbp2: switch flavor of MODE SENSE
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <tkrat.9abbd263c892fb65@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It became apparent lately that MODE SENSE (6) is more palatable to some
SBP-2 devices and is more popular among other OSs than MODE SENSE (10).
The RBC spec disagrees with sbp2 too.

 - ieee1394: sbp2: don't prefer MODE SENSE 10
   (supercedes recent workaround for write protect bit of Initio firmware)
 - ieee1394: sbp2: enable auto spin-up for all SBP-2 devices
   (old patch, reposted in refreshed form to be reapplied smoothly without
   the Initio workaround underneath)
-- 
Stefan Richter
-=====-=-==- =--= -=---
http://arcgraph.de/sr/

