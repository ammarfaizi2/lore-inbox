Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTFGHu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTFGHu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:50:27 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:40461 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262714AbTFGHuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:50:22 -0400
Date: Sat, 7 Jun 2003 10:03:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Docbook update
Message-ID: <20030607080357.GB8943@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030607080226.GA8943@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607080226.GA8943@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1316  -> 1.1316.1.1
#	Documentation/DocBook/kernel-api.tmpl	1.25    -> 1.26   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/07	sam@mars.ravnborg.org	1.1316.1.1
# docbook/kernel-api: include files updated
# 
# Path to pci_hotplug_core corrected.
# Added !Eli/string.h to document strlcpy and friends
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	Sat Jun  7 09:53:51 2003
+++ b/Documentation/DocBook/kernel-api.tmpl	Sat Jun  7 09:53:51 2003
@@ -79,6 +79,7 @@
      </sect1>
      <sect1><title>String Manipulation</title>
 !Ilib/string.c
+!Elib/string.c
      </sect1>
      <sect1><title>Bit Operations</title>
 !Iinclude/asm-i386/bitops.h
@@ -176,7 +177,7 @@
 !Edrivers/pci/pci.c
      </sect1>
      <sect1><title>PCI Hotplug Support Library</title>
-!Edrivers/hotplug/pci_hotplug_core.c
+!Edrivers/pci/hotplug/pci_hotplug_core.c
      </sect1>
      <sect1><title>MCA Architecture</title>
 	<sect2><title>MCA Device Functions</title>
