Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWGFMr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWGFMr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 08:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWGFMr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 08:47:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17319 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030240AbWGFMrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 08:47:24 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/6] Fix FRV, ELF-FDPIC and NOMMU stuff [try #3]
Date: Thu, 06 Jul 2006 13:47:16 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patches:

 (1) Fix compilation errors and other problems in the FRV arch and the
     ELF-FDPIC binfmt driver.

 (2) Fix a problem with the NOMMU ramfs filesystem when executing binaries
     stored therein.

 (3) Fix up the ELF-FDPIC coding style and implement a minor change to reduce
     the number of times ksize() is called.

 (4) Add ELF-FDPIC coredump support.

 (5) Make the FRV arch make use of the asm-offsets stuff.

In [try #2] the following change has been made:

 (*) Inclusions of <linux/config.h> added by the patches have been dropped as
     they're not necessary.

In [try #3]:

 (*) ELF-FDPIC Coding style fixups.

 (*) Minor ELF-FDPIC change to reduce the number of times ksize() is called.
