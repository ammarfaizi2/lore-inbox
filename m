Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265061AbVBDVG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbVBDVG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264885AbVBDVG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:06:28 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:4518 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264233AbVBDVGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:06:07 -0500
Subject: [PATCH 0/3] refactor i386 memory setup
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andy Whitcroft <apw@shadowen.org>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 13:05:55 -0800
Message-Id: <1107551155.9084.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following 3 patches help to make some of the i386 NUMA code a bit
more manageable, and remove a lot of duplicate code in the process.  All
3 together were test-booted on a NUMA-Q, Summit, and a regular old
laptop.

They're in no hurry to get merged, and could wait for the 2.6.12 series.

-- Dave

