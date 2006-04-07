Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWDGOhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWDGOhc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWDGOhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:37:03 -0400
Received: from [151.97.230.9] ([151.97.230.9]:48092 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932354AbWDGOcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:24 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 00/17] Uml little fixups for new and existing code [for 2.6.17]
Date: Fri, 07 Apr 2006 16:27:09 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of little patches for compilation fixups, error path bugs and the like.
New "features" are support for running sparse on userspace files, a Makefile
cleanup, and finally working around the COW format incompatibility between 32
and 64 bit UMLs; the last one has been tested for a while.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
