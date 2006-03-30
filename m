Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWC3IT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWC3IT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWC3IRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:17:45 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:20307 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932097AbWC3IRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:17:41 -0500
Message-Id: <20060330081605.085383000@localhost.localdomain>
Date: Thu, 30 Mar 2006 16:16:05 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch 0/8] list.h related cleanups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set does:

- Introduce hlist_add_head() and use it
- Use list_add_tail() instead of list_add(A, B.prev)
- Use list_move() instead of the combination of list_del() and list_add()

for readability and micro optimization.
--
