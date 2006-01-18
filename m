Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbWASABe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbWASABe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbWARX7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:59:38 -0500
Received: from [151.97.230.9] ([151.97.230.9]:10217 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030470AbWARX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:59:36 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 0/8] Other UML batch
Date: Thu, 19 Jan 2006 00:51:32 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118235132.4626.74049.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various little UML fixups. The only non-trivial one is "uml: fix hugest stack
users", which avoids C99 initializers for huge (6k) structs (due to the "copy
them twice on the stack" gcc niceness).

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
