Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271158AbUJVBgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271158AbUJVBgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271176AbUJVBbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:31:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16851 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S271161AbUJVBTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:19:11 -0400
Message-ID: <41785FE3.806@engr.sgi.com>
Date: Thu, 21 Oct 2004 18:18:27 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lse-tech <lse-tech@lists.sourceforge.net>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: [PATCH 2.6.9 0/2] enhanced accounting data collection
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are the one we submitted to SuSE for Sles9 SP1.
They are clean of CSA specific code.

In earlier round of discussion, all partipants favored  a common
layer of accounting data collection. I believe these two patches are
the super set that meets the needs of people who need enhanced BSD 
accounting.

This patchset consists of two parts: acct_io and acct_mm, as we
identified improved data collection in the area of IO and MM are
useful to our customers.

It is intended to offer common data collection method for various
accounting packages including BSD accouting, ELSA, CSA, and any other
acct packages that favor a common layer of data collection.

'acct_mm' defines a few macros that are no-op unless
CONFIG_BSD_PROCESS_ACCT config flag is set on.

Andrew, please consider including these two patches. Please let me
know how i can help!

Best Regards,
---
Jay Lan - Linux System Software
Silicon Graphics Inc., Mountain View, CA

