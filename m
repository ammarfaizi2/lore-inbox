Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTEUHzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTEUHmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:42:42 -0400
Received: from zeus.kernel.org ([204.152.189.113]:58838 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261544AbTEUHlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:41:44 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16075.8557.309002.866895@napali.hpl.hp.com>
Date: Tue, 20 May 2003 23:49:17 -0700
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@linuxia64.org
Subject: web page on O(1) scheduler
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I started to look into some odd performance behaviors of the
O(1) scheduler.  I decided to document what I found in a web page
at:

	http://www.hpl.hp.com/research/linux/kernel/o1.php

(it may take another couple of hours before the pages show up outside
the HP firewall, so if you get "page not found" at the moment, don't
be surprised).

I should say that I have no direct stake in the CPU scheduler (never
worked on it, not sure I ever would want to), but I feel that it's
worthwhile to at least document the O(1) scheduler a bit better.
Also, I do feel that the O(1) scheduler currently has rather poor
"long-term" properties.  It would be nice if some of those properties
could be improved without hurting the other excellent properties of
the current O(1) scheduler.

I think the web pages should be most relevant to the HPTC (high
performance technical computing) community, since this is the
community that is most likely affected by some of the performance
oddities of the O(1) scheduler.  Certainly anyone using OpenMP on
Intel platforms (x86 and ia64) may want to take a look.

Comments welcome.

	--david
