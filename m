Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbUKCJBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbUKCJBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUKCJBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:01:05 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:3838 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261489AbUKCJA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:00:58 -0500
Date: Wed, 3 Nov 2004 14:40:36 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       wli@holomorphy.com
Subject: [PATCH 0/6] AIO wait bit support
Message-ID: <20041103091036.GA4041@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The series of patches that follow integrate AIO with 
William Lee Irwin's wait bit changes, to support asynchronous
page waits.

[1] modify-wait-bit-action-args.patch
	Add a wait queue arg to the wait_bit action() routine

[2] lock_page_slow.patch
	Rename __lock_page to lock_page_slow

[3] init-wait-bit-key.patch
	Interfaces to init and to test wait bit key

[4] tsk-default-io-wait.patch
	Add default io wait bit field in task struct

[5] aio-wait-bit.patch
	AIO wake bit and AIO wait bit

[6] aio-wait-page.patch
	AIO wait page and lock page

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

