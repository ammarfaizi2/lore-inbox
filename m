Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752488AbWAFS6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbWAFS6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbWAFS6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:58:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40096 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752482AbWAFS57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:57:59 -0500
Date: Fri, 6 Jan 2006 13:57:49 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200601061857.k06IvnR8023978@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: akpm@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a little update and relative to the current sources.

The only code change are three lines of code: renaming fchmod to fchmodat,
adding a new parameter, passing it to __user_walk_fd, and a new one-line
wrapper function sys_chmod.  The other changes are hooking up the syscall
and the previously not-hooked-up faccessat syscal.
