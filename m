Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbWH2Qpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWH2Qpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWH2Qpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:45:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13213 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965105AbWH2Qpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:45:52 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 00/19] BLOCK: Permit block layer to be disabled [try #5]
Date: Tue, 29 Aug 2006 17:45:49 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches permits the block layer to be disabled and removed from
the compilation such that it doesn't take up any resources on systems that
don't need it.

This set of patches is against the block git tree.

Changes in [try #5]:

 (*) Update to block GIT tree for 2.6.18-rc5.

 (*) Make USB_STORAGE depend on SCSI rather than selecting it.

 (*) Remove dependencies on BLOCK where there are also dependencies on SCSI.

David
