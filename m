Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319022AbSIIVZK>; Mon, 9 Sep 2002 17:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319024AbSIIVZK>; Mon, 9 Sep 2002 17:25:10 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:36083 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S319022AbSIIVZJ>; Mon, 9 Sep 2002 17:25:09 -0400
Date: Mon, 9 Sep 2002 14:24:30 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [TRIVIAL] 2.5.34 kernel-api DocBook fix
Message-ID: <20020909142430.A2017@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	Trivial Kernel Patches <trivial@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update kernel-api.tmpl to reflect mtrr changes so that the docs will build.

thanks,
-chris

--- 2.5.34/Documentation/DocBook/kernel-api.tmpl	Wed Jul 31 07:43:38 2002
+++ 2.5.34-doc/Documentation/DocBook/kernel-api.tmpl	Mon Sep  9 13:19:29 2002
@@ -161,7 +161,7 @@
      </sect1>
 
      <sect1><title>MTRR Handling</title>
-!Earch/i386/kernel/mtrr.c
+!Earch/i386/kernel/cpu/mtrr/main.c
      </sect1>
      <sect1><title>PCI Support Library</title>
 !Edrivers/pci/pci.c
