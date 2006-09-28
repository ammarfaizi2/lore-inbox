Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWI1VZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWI1VZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWI1VZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:25:13 -0400
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:40376 "EHLO
	hachi.dashjr.org") by vger.kernel.org with ESMTP id S1161008AbWI1VZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:25:11 -0400
From: Luke-Jr <luke@dashjr.org>
Organization: -Jr family
To: linux-kernel@vger.kernel.org
Subject: PCI bridge missing
Date: Thu, 28 Sep 2006 16:24:15 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609281624.16082.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This applies to Debian sarge kernels kernel-image-2.4.27-2-686, 2.6.8-3-686, 
2.6.16-2-686, and 2.6.17-2-686...
I am trying to setup a Dell Optiplex GX1p system, which has a daughterboard 
PCI bridge for its PCI and ISA slots:
00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)

However, this bridge is completely ignored and unseen by Linux. It does not 
show up in lspci or dmesg (as far as I can tell) at all. The daughterboard is 
plugged in, and the PCI cards on it are powered.

How could I go about troubleshooting the problem? Has anyone experienced 
something like this before?

Thanks,

Luke-Jr

P.S. Please CC me if possible.
