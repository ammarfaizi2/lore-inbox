Return-Path: <linux-kernel-owner+w=401wt.eu-S1751158AbWLOGwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWLOGwe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 01:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWLOGwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 01:52:34 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47531 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbWLOGwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 01:52:32 -0500
Date: Thu, 14 Dec 2006 22:51:39 -0800
Message-Id: <200612150651.kBF6pdkl025501@zach-dev.vmware.com>
Subject: [PATCH 0/6] VMI paravirt-ops patches
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 15 Dec 2006 06:51:39.0959 (UTC) FILETIME=[78FCE470:01C72015]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the patches for the VMI backend to paravirt-ops.  Base
kernel where I tested them was 2.6.19-git20.

Basically, there are only a couple of hooks needed that were left
out of the initial paravirt-ops merge, and then the backend code
is a very straightforward implementation of the paravirt-ops
functions.

Andrew or Linus, please apply or shoot me nasty feedback that I
will promptly turn into marvelous looking code.  I've Cc'd Andi,
who originally was going to take up the patches, but seems to
have been snowed in.

Zach
