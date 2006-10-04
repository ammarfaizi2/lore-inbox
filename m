Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161118AbWJDHoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbWJDHoo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030651AbWJDHoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:44:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24810 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030646AbWJDHon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:44:43 -0400
Date: Wed, 4 Oct 2006 03:44:34 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: another attempt to kill off linux/config.h
Message-ID: <20061004074434.GA13672@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every time I (or someone else) gets a patch included
removing explicit includes of linux/config.h, another few creep
into the tree a day or so later.

Lets kill them all for good.

master.kernel.org:/pub/scm/linux/kernel/git/davej/configh.git

is a git tree killing off all the current users in tree,
and adds a #warn to include/linux/config.h that it's going away.
(This should still leave as-yet-unmerged trees compiling,
 and hopefully get them fixed before they get merged)
We can then remove the file for real just before 2.6.19

	Dave

-- 
http://www.codemonkey.org.uk
