Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWHOSAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWHOSAh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWHOSAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:00:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61387 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030417AbWHOSAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:00:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>,
       Linux Containers <containers@lists.osdl.org>
Subject: The rest of my proc cleanup.
Date: Tue, 15 Aug 2006 12:00:21 -0600
Message-ID: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There were enough changes in my last round of cleaning up
proc I had to break up the patch series into smaller chunks,
and my last chunk never got resent.

This patchset gives proc dynamic inode numbers (the static inode
numbers were a pain to maintain and prevent all kinds of things), and
removes the horrible switch statements that had to be kept in sync
with everything else.  Being fully table driver takes us 90% of the
way of being able to register new process specific attributes in proc.

Before I start on the next set of changes to proc I want to get
this set out of my hair.

Eric
