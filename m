Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWAQUVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWAQUVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWAQUUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:20:48 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:58084 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964786AbWAQUUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:20:24 -0500
Message-Id: <20060117194942.647145000@klappe.arndb.de>
Date: Tue, 17 Jan 2006 20:49:42 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jordi_caubet@es.ibm.com,
       Mark Nutter <mnutter@us.ibm.com>
Subject: [RFC/PATCH 0/3] cell/spufs: new experimental features
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These three patches implement features that are
desired by many of the cell/spufs users in order
to improve performance and functionality of cell
specific applications.

Since they all touch very sensitive parts of the
kernel (memory management and system calls), I
would at least like a thorough review before
declaring the interfaces stable and submitting the
patches for inclusion.

	Arnd <><
-

