Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUCCDXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbUCCDXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:23:45 -0500
Received: from dns1.outlandz.net ([66.132.132.24]:23525 "EHLO
	dns1.outlandz.net") by vger.kernel.org with ESMTP id S262339AbUCCDXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:23:44 -0500
Subject: [TRIVIAL][PATCH] Fixes Documentation/kbuild/kconfig-language
From: "Matthew J. Fanto" <mattjf@uncompiled.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1078284202.355.3.camel@nemesis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 22:23:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for kconfig says one of the types is integer. It's
actually int. I had to search for a few minutes to find the actual type,
so even though it's trivial, hopefully it makes it clear for others. 


--- kconfig-language.txt        2004-02-27 17:21:00.000000000 -0500
+++ kconfig-language.txt-int    2004-03-02 22:18:48.000000000 -0500
@@ -48,7 +48,7 @@
 A menu entry can have a number of attributes. Not all of them are
 applicable everywhere (see syntax).

-- type definition: "bool"/"tristate"/"string"/"hex"/"integer"
+- type definition: "bool"/"tristate"/"string"/"hex"/"int"
   Every config option must have a type. There are only two basic types:
   tristate and string, the other types are based on these two. The type
   definition optionally accepts an input prompt, so these two examples


