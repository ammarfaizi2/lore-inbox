Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbWH2SF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbWH2SF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWH2SF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:05:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20452 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965199AbWH2SF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:05:56 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 00/19] BLOCK: Permit block layer to be disabled [try #6]
Date: Tue, 29 Aug 2006 19:05:52 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches permits the block layer to be disabled and removed from
the compilation such that it doesn't take up any resources on systems that
don't need it.

This set of patches is against the block git tree.

Changes in [try #6]:

 (*) Remove all traces of block_sync_page() from AFS.

Changes in [try #5]:

 (*) Update to block GIT tree for 2.6.18-rc5.

 (*) Make USB_STORAGE depend on SCSI rather than selecting it.

 (*) Remove dependencies on BLOCK where there are also dependencies on SCSI.

David
