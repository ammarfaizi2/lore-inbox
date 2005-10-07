Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbVJGRqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbVJGRqF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030531AbVJGRqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:46:05 -0400
Received: from fmr19.intel.com ([134.134.136.18]:15017 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030530AbVJGRqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:46:02 -0400
Subject: [patch 0/2] acpiphp: hotplug adapters with bridges on them
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Cc: rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Oct 2005 10:45:45 -0700
Message-Id: <1128707145.11020.9.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 07 Oct 2005 17:45:47.0218 (UTC) FILETIME=[F2E5DB20:01C5CB66]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These 2 patches will allow adapters with p2p bridges on them to be
successfully hotplugged using the acpiphp driver.  Currently, if you
attempt to hotplug an adapter with a p2p bridge on it, the operation
will fail because resources are not allocated to it properly.  These
patches have had very limited testing as I only have one machine and one
type of adapter to test this with.  I tested this with 2.6.14-rc2, but
the patch applies fine to rc3 as well.


