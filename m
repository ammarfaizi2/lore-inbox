Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVALQXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVALQXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVALQXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:23:21 -0500
Received: from mrdec-exch.amrdec.army.mil ([199.209.144.25]:42767 "EHLO
	mrdec-owa.ds.amrdec.army.mil") by vger.kernel.org with ESMTP
	id S261210AbVALQXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:23:19 -0500
Message-ID: <CE14215C87EAAF4B9AD862BB49625057048E820C@ssdd-cluster.ds.amrdec.army.mil>
From: "Reynolds, Terry (Contractor-SIMTECH)" <terry.reynolds2@us.army.mil>
To: "Linux-Kernel@Vger. Kernel. Org (linux-kernel@vger.kernel.org)" 
	<linux-kernel@vger.kernel.org>
Subject: Realtime-preemtp-2.6.10...-01 on a ppc64?
Date: Wed, 12 Jan 2005 10:13:37 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
 
I've installed the patches on 2.6.10 (2.6.10-mm1 & realtime-preempt-2.6.10
... .34-01) on my G5 desktop.  The realtime patched kernel wont compile, as
it has a large number of re-defined & conflicting types.  Including:
 
spinlock_t
rwlock_t
SPIN_LOCK_UNLOCKED
RW_LOCK_UNLOCKED
and lots of _raw_.*lock types.
 
It seems the ppc64 architecture hasn't been fleshed out yet for the
real-time preemption patches, or did I just do something moronic?
 
I'm sitting in front of a couple of G5 desktops and I'd like to help test /
checkout / work on this branch!

TIA.
 
Terry Reynolds
Simulation Technologies, INC.

