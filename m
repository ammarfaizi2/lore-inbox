Return-Path: <linux-kernel-owner+w=401wt.eu-S1030316AbXAEEfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbXAEEfe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 23:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbXAEEfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 23:35:34 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:51901 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030316AbXAEEfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 23:35:32 -0500
Date: Thu, 4 Jan 2007 20:35:07 -0800
Message-Id: <200701050435.l054Z7Zv005529@zach-dev.vmware.com>
Subject: [PATCH 0/3] VMI hotfixes
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Eli Collins <ecollins@vmware.com>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 05 Jan 2007 04:35:30.0250 (UTC) FILETIME=[EE22FAA0:01C73082]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hotfixes for VMI code from -rc2-mm1.  This fixes several critical
problems, a compile fix for +PARAVIRT+VMI-SMP, a bogus indirect
call to a VMI function on native, and corrects the FS/GS startup
state for SMP to match the new FS/GS PDA changes.
