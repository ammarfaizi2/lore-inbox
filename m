Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWDNCIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWDNCIi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWDNCIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:08:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:5174 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965057AbWDNCIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:08:37 -0400
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23803713:sNHT15495942"
Subject: [PATCH 0/8] IA64 various hugepage size - Overview
From: Zou Nan hai <nanhai.zou@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org
Cc: Luck@vger.kernel.org, Tony <tony.luck@intel.com>, Chen@vger.kernel.org,
       Kenneth W <kenneth.w.chen@intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1144974367.5817.39.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Apr 2006 08:26:07 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add support to have different
hugepage sizes for different tasks on IA64.

While still keep the kernel compatible to old applications.

With this patch, application can set it's huge page size via
a prctl syscall. 

Then different hugepage sized applications can co-work together.

Zou Nan hai




