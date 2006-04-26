Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWDZCLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWDZCLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWDZCLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:11:23 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:6796 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932343AbWDZCLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:11:23 -0400
Message-Id: <20060426021059.235216000@localhost.localdomain>
Date: Wed, 26 Apr 2006 10:10:59 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch 0/3] use kref
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use kref instead of atomic reference counter at:

- blk_queue_tag
- io_context
- bio

--
