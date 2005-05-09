Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVEIXXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVEIXXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVEIXXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:23:00 -0400
Received: from [151.97.230.9] ([151.97.230.9]:31762 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261388AbVEIXVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:21:38 -0400
Subject: [patch 1/6] uml: remove elf.h [ compile-fix, for 2.6.12 ]
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 10 May 2005 00:45:08 +0200
Message-Id: <20050509224509.0C105416E4@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually remove elf.h in the tree. The previous patch, due to a quilt
bug/misuse, left it in the tree as a 0-length file, preventing the build to
see it as missing and to generate a symlink in its place.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

  |    0 
 1 files changed

diff -L include/asm-um/elf.h -puN include/asm-um/elf.h~uml-remove-elf-h /dev/null
_
