Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWGERyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWGERyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWGERyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:54:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32406 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964933AbWGERyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:54:51 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/5] Fix FRV, ELF-FDPIC and NOMMU stuff [try #2]
Date: Wed, 05 Jul 2006 18:54:40 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20060705175440.12594.43069.stgit@warthog.cambridge.redhat.com>
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

 (3) Add ELF-FDPIC coredump support.

 (4) Make the FRV arch make use of the asm-offsets stuff.

In [try #2] the following change has been made:

 (*) Inclusions of <linux/config.h> added by the patches have been dropped as
     they're not necessary.
