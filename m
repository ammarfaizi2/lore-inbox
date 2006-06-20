Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWFTRhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWFTRhn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWFTRhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:37:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750706AbWFTRhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:37:42 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/6] Keys: Key management updates  [try #3]
Date: Tue, 20 Jun 2006 18:37:35 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Message-Id: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches update a few key management related things, mainly security
related.  They have the following prerequisite patches from Andrew Morton's -mm
tree:

	selinux-add-hooks-for-key-subsystem.patch
	keys-fix-race-between-two-instantiators-of-a-key.patch

Some of these patches have been modified from the originals I've been given so
that they'll all apply in sequence.

David
