Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319007AbSIDCM4>; Tue, 3 Sep 2002 22:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319010AbSIDCMz>; Tue, 3 Sep 2002 22:12:55 -0400
Received: from zok.SGI.COM ([204.94.215.101]:58309 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S319007AbSIDCMy>;
	Tue, 3 Sep 2002 22:12:54 -0400
Message-ID: <3D756DA3.8DD9941D@alphalink.com.au>
Date: Wed, 04 Sep 2002 12:19:15 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Build Mailing List <kbuild-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ANNOUNCE: gcml2 version 0.7.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

gcml2 is (among other things) a Linux kconfig language syntax checker.
Version 0.7.1 is available at:

http://sourceforge.net/project/showfiles.php?group_id=18813&release_id=108721

and

http://www.alphalink.com.au/~gnb/gcml2/download.html

This is a bugfix release of gcml2.  Thanks to Randy Dunlap in particular
for reporting problems.  Future announcements of minor releases will be
on the kbuild-devel list only.

Here is a brief change log.

* Fixed memory corruption error where the banner node was being
  freed but not removed from the hashtable of all nodes.
* The CONFIG_DECSTATION bug in the mips port triggered an assert
  failure in the overlap code; this case is now handled more
  gracefully.
* Added two new warnings, condition-loop and dependency-loop.
* Gracefully handle case where a define_bool is conditional on itself.
* Fixed misfeature where failure to find a "source"d file would
  terminate parsing the remainder of the rulebase.
* Using a symbol name instead of a sub-prompt as the default
  value for a "choice" no longer causes a parse error.
* Various minor bugs, memory leaks, speed improvements.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
