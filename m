Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTJID1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 23:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTJID1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 23:27:32 -0400
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:38055 "EHLO
	office.lsg.internal") by vger.kernel.org with ESMTP id S261882AbTJID1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 23:27:31 -0400
Message-ID: <3F84D5A0.5050709@backtobasicsmgmt.com>
Date: Wed, 08 Oct 2003 20:27:28 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: 2.6.0-test7 "make oldconfig" breaks with O=...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unpacked a complete fresh source tree (from -test1 patched up to 
-test7), then did

make O=../linux-foo oldconfig

where ../linux-foo is an object-only tree previously successfully used 
with -test6.

This is what I got back for my efforts :-)

----

make[2]: `scripts/fixdep' is up to date.
   HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
gcc: /storage/work/linux-2.6/scripts/kconfig/zconf.tab.c: No such file 
or directory
gcc: No input files
make[2]: *** [scripts/kconfig/zconf.tab.o] Error 1
make[1]: *** [oldconfig] Error 2
make: *** [oldconfig] Error 2

