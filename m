Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWH0I2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWH0I2u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWH0I2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:28:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28345 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751691AbWH0I2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:28:49 -0400
Date: Sun, 27 Aug 2006 10:25:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       cramerj@intel.com, john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com
Subject: e1000 driver contains private copy of GPL... and modified one, too
Message-ID: <20060827082534.GA2397@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Okay, so modifications are not major: different address of free
software foundation, completely different formatting, some characters
added, and some characters removed. It no longer contains Linus'
clarifications.

--- LICENSE     2006-07-21 05:42:27.000000000 +0200
+++ ../../../COPYING    2006-07-21 05:42:27.000000000 +0200
@@ -1,128 +1,141 @@

-"This software program is licensed subject to the GNU General Public License
-(GPL). Version 2, June 1991, available at
-<http://www.fsf.org/copyleft/gpl.html>"
+   NOTE! This copyright does *not* cover user programs that use kernel
+ services by normal system calls - this is merely considered normal use
+ of the kernel, and does *not* fall under the heading of "derived work".
+ Also note that the GPL below is copyrighted by the Free Software
+ Foundation, but the instance of code that it refers to (the Linux
+ kernel) is copyrighted by me and others who actually wrote it.
+
+ Also note that the only valid version of the GPL as far as the kernel
+ is concerned is _this_ particular version of the license (ie v2, not
+ v2.2 or v3.x or whatever), unless explicitly otherwise stated.

-GNU General Public License
+                       Linus Torvalds

+----------------------------------------
+
+                   GNU GENERAL PUBLIC LICENSE
 Version 2, June 1991

 Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-59 Temple Place - Suite 330, Boston, MA  02111-1307, USA
-
-Everyone is permitted to copy and distribute verbatim copies of this license
-document, but changing it is not allowed.
+                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.

 Preamble

Missing line in Intel's version:

-The precise terms and conditions for copying, distribution and modification
-follow.
+  The precise terms and conditions for copying, distribution and
+modification follow.

+                   GNU GENERAL PUBLIC LICENSE
 TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION


For some reason Intel's version likes stars:

-   * a) Accompany it with the complete corresponding machine-readable source
-        code, which must be distributed under the terms of Sections 1 and 2
-        above on a medium customarily used for software interchange; or,
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,

...and hates ^Ls and <,>s.

 Yoyodyne, Inc., hereby disclaims all copyright interest in the program
-'Gnomovision' (which makes passes at compilers) written by James Hacker.
+  `Gnomovision' (which makes passes at compilers) written by James Hacker.

-signature of Ty Coon, 1 April 1989
+  <signature of Ty Coon>, 1 April 1989
 Ty Coon, President of Vice

Now... I believe nothing evil is going on, but having two slightly
different copies of GPL in one source seems wrong, can we get rid of
e1000 one?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
