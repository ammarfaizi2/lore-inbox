Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWB1Syr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWB1Syr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWB1Syr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:54:47 -0500
Received: from gate.cs.rochester.edu ([192.5.53.207]:12515 "EHLO
	gate.cs.rochester.edu") by vger.kernel.org with ESMTP
	id S932413AbWB1Syq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:54:46 -0500
Date: Tue, 28 Feb 2006 13:54:45 -0500 (EST)
From: Keith Parkins <kparkins@cs.rochester.edu>
To: linux-kernel@vger.kernel.org
Subject: newbie -- looking for 2.4->2.6 PCI example
Message-ID: <Pine.LNX.4.44.0602281343520.30773-100000@svankmajer.cs.rochester.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I am about to port a small PCI module (~500 lines) from a 2.4 to a 2.6
kernel. I browsed Jonathon Corbet's articles on lwn.net but didn't notice
any discussion on the pci differences. Could somebody point me to a small
straightforward driver in the 2.4 tree that has an equally straightforward
source in the 2.6 tree?  The existing driver has poll, ioctl, open,
release, probe, and remove callbacks and that's it. It also uses a mutex
and spin_lock for polling and ioctl when calling
copy_from_user/copy_to_user.

Thanks!
Keith

-- 
Keith Parkins                   U of R Computer Science
kparkins@cs.rochester.edu       Computer Science Building, Room 606
(585) 275-1118

