Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268070AbUHKO0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268070AbUHKO0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 10:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268071AbUHKO0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 10:26:22 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:2898
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S268070AbUHKO0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 10:26:21 -0400
Message-Id: <s11a3a9c.002@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Wed, 11 Aug 2004 16:26:23 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: i386 cache flush from user space exception
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/traps.c, in function do_simd_coprocessor_error, refers
to such an undocumented thing. I haven't been successful in finding any
references elsewhere to such behavior, and hence I found the only choice
would be to ask here whether anyone can provide some background and/or
pointers to what functionality is being dealt with here.

Thanks a lot, Jan
