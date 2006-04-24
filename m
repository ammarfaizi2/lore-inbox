Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWDXIeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWDXIeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbWDXIeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:34:17 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:37476 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751132AbWDXIeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:34:16 -0400
Message-Id: <20060424083333.217677000@localhost.localdomain>
Date: Mon, 24 Apr 2006 16:33:33 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch 0/4] kref debugging
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces the DEBUG_KREF config option.

It adds another debug check to detect kref_put() with unreferenced
kref object, and splits all kref debug checks  into this config option.
Also it can be disable or enable in run-time by sysctl.
--
