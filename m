Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbTJKMLY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 08:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbTJKMLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 08:11:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54259 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263312AbTJKMLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 08:11:22 -0400
Date: Sat, 11 Oct 2003 14:11:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: CONFIG_AGP_AMD_{8151->K8} Configure.help entry
Message-ID: <20031011121107.GV24300@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.23-pre CONFIG_AGP_AMD_8151 was renamed to CONFIG_AGP_AMD_K8, but 
the configure.help entry was forgotten. he following trivial patch fixes 
this:

--- linux-2.4.23-pre7-full/Documentation/Configure.help.old	2003-10-11 14:05:48.000000000 +0200
+++ linux-2.4.23-pre7-full/Documentation/Configure.help	2003-10-11 14:06:02.000000000 +0200
@@ -4013,7 +4013,7 @@
   You should say Y here if you use XFree86 3.3.6 or 4.x and want to
   use GLX or DRI.  If unsure, say N.
 
-CONFIG_AGP_AMD_8151
+CONFIG_AGP_AMD_K8
   This option gives you AGP support for the GLX component of
   XFree86 on an AMD Opteron/Athlon64 using the on-CPU GART.
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

