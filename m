Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVBWKld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVBWKld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 05:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVBWKld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 05:41:33 -0500
Received: from winds.org ([68.75.195.9]:39879 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S261404AbVBWKlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 05:41:32 -0500
Date: Wed, 23 Feb 2005 05:41:30 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: linux-kernel@vger.kernel.org
Subject: Q: Shared Memory vs. Ramdisk?
Message-ID: <Pine.LNX.4.61.0502230535220.4512@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have an application on x86-64 that will require me sharing two memory
segments upwards of 10+ GB each among several processes. Would it be better
performance-wise to mmap in two files from a tmpfs filesystem, or, create two
large ramdisks (/dev/ram0 & /dev/ram1) and mmap those in?

I'm not concerned about swap, but rather just trying to avoid as much kernel
overhead as possible while accessing gobs of memory.

Thanks,
  -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
