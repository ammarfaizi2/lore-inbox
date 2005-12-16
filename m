Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVLPXOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVLPXOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVLPXOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:14:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31708 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964818AbVLPXN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:26 -0500
Date: Fri, 16 Dec 2005 23:13:06 GMT
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 0/12]: MUTEX: Introduce mutex implementation
Message-Id: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches implements mutexes as an alternative to semaphores where
such more restricted behaviour is appropriate.

There are several changes that might be appropriate to these patches:

 (1) Name DECLARE_MUTEX as DEFINE_MUTEX in linux/mutex-*.h

 (2) Make mutex_trylock()'s return value consistent with semaphores rather
     than everything else.

 (3) Drop the testing module (patch 12/12). I'm not sure I've got the plumbing
     correct in the master makefile.

Patches to come after Christmas will include sem -> completion conversions and
sem -> mutex conversions.

Merry Christmas!

David
