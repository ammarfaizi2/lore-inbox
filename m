Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWFNXHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWFNXHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWFNXHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:07:46 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:21445 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S965000AbWFNXHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:07:46 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mike Miller <mike.miller@hp.com>
Subject: [PATCH 0/7] CCISS cleanups
Date: Wed, 14 Jun 2006 17:07:27 -0600
User-Agent: KMail/1.8.3
Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606141707.27404.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of minor cleanups to the cciss (HP Smart Array) driver:

  1  disable device before returning failure
  2  claim all resources the device decodes, not just I/O ports
  3  print more useful identification when driver claims device
  4  remove intermediate #define for ARRAY_SIZE
  5  fix spelling errors
  6  unparenthesize "return" statements
  7  Lindent (warning, huge diff, but changes whitespace only)
  
They're in order of usefulness.
