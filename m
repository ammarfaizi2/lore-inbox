Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbTEHXQl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTEHXQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:16:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19333 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262247AbTEHXQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:16:40 -0400
Subject: [PATCH 2.5.69 1/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052436552.2492.32.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 08 May 2003 16:29:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a sequence counter only version of the reader/writer
consistent mechanism to seqlock.h  This is used in the second
part of this patch give atomic access to i_size.

re-diff against 2.5.69.

The patch is also available for download from OSDL's patch lifecycle 
manager (PLM):

http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1834

-- 
Daniel McNeil <daniel@osdl.org>

