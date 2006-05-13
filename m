Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWEMQFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWEMQFj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWEMQFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:05:39 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:17914 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932463AbWEMQFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:05:39 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [RFC PATCH 2.6.17-rc4 0/6] Kernel memory leak detector
Date: Sat, 13 May 2006 16:57:57 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060513155757.8848.11980.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first attempt at a kernel memory leak detector based on
the tracing garbage collection technique (similar to Valgrind's
"memcheck --leak-check" tool). See the Documentation/kmemleak.txt file
for a more detailed description.

The implementation is not complete and the code might contain
bugs. Only the ARM and i386 architectures are supported at the moment.

Let me know what you think. Thanks.

-- 
Catalin
