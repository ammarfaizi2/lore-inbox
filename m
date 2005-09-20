Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932761AbVITRXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbVITRXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbVITRXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:23:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:38061 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932761AbVITRXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:23:11 -0400
Subject: [RFC][PATCH 0/4] unify both copies of build_zonelists()
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 20 Sep 2005 10:23:03 -0700
Message-Id: <20050920172303.8CD9190C@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently two copies of build_zonelists(): one
for NUMA systems, and one for flat systems.  The following
patches make the NUMA case work for the flat case as well.

This set is a little more thorough than the single patch
I posted last week.

I'd like these to get a run in -mm if there aren't any
objections.
