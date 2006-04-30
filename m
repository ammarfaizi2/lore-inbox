Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWD3QvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWD3QvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 12:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWD3QvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 12:51:09 -0400
Received: from host2-39.pool8261.interbusiness.it ([82.61.39.2]:28137 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751170AbWD3QvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 12:51:08 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 0/2] Fixes for umid code for 2.6.17
Date: Sun, 30 Apr 2006 17:33:26 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060430153326.27676.64906.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I had forgot these two ones from previous series. I've found a bug in
startup code (related to new code in 2.6.17) and here's the fix - it is not a
"just fix this", there's a tiny bit of reorganization but not much (splitting
functions and changing their return conventions).

>From stg series:

+ uml-not_dead_yet-remove-existing-dir   | uml: fix not_dead_yet when
	directory is in bad state
+ uml-rename-improve-actually_do_remove  | uml: rename and improve
	actually_do_remove()

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
