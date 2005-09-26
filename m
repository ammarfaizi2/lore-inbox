Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbVIZMLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbVIZMLF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVIZMLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:11:04 -0400
Received: from web51009.mail.yahoo.com ([206.190.39.128]:62891 "HELO
	web51009.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751537AbVIZMLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:11:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=j+QBGqXfgw4g+k6eNpUfy+TDBxoK/37BLoIYwxYMR5JCtMrAYc+Y/ENpvPZkD4PKYFdhPRG/9gV5kDoXznCKarwdal8b4BTZIRYvttxk6arl9l3b83QKTUpYR/oH876F6K7hLp/WGMTmPB0z2c13J1V/zkoa4HpCq6ZOz3MIbMI=  ;
Message-ID: <20050926121102.42092.qmail@web51009.mail.yahoo.com>
Date: Mon, 26 Sep 2005 05:11:01 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: [PATCH](document) Automatic Configuration of a Kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---
linux.org/Documentation/kbuild/kconfig-language.txt
2005-09-23 09:27:05.000000000 +0200
+++
linux-2.6.13.2/Documentation/kbuild/kconfig-language.txt
2005-09-25 22:09:35.000000000 +0200
@@ -113,6 +113,20 @@
   used to help visually seperate configuration logic
from help within
   the file as an aid to developers.
 
+- autoconfiguration: "autorule" rule ["parameter"]
+  This defines the name of a rule, for choosing the
config automatically.
+  The purpose of a rule is to check the target-system
and tell whether 
+  the config can be chosen or not. A rule can be a
executable script, 
+  binary or whatever. They  must be insert in the
directory 
+  scripts/kconfig/rules/. Every rule has to give its
answer(y or n) 
+  out to the STDOUT. You can even define a Parameter
for your rule,
+  but it has to be quoted. 
+  Those rules will be respond by typing  "make
autoconfig" or
+  "make autochoiceconfig".
+  By "make autoconfig" all the elected-configs will
be choosen automatically 
+  as build-in.
+  By "make autochoiceconfig" the user will be asked
for choosing the elected-config.
+    
 
 Menu dependencies
 -----------------





		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
