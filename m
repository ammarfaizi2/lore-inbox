Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbTGCSHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 14:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTGCSHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 14:07:04 -0400
Received: from main.gmane.org ([80.91.224.249]:8630 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265172AbTGCSHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 14:07:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.5.74-mm1
Date: Thu, 3 Jul 2003 18:11:00 +0000 (UTC)
Message-ID: <be1rjk$nj$1@main.gmane.org>
References: <20030703023714.55d13934.akpm@osdl.org>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Cc: linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.5.74-mm1/
> 

Has -mm had some monotonic clock patches at around 2.5.72-mm3?
2.5.74-mm1 seems to produce non-monotonic gettimeofday.
(tested with http://www.swcp.com/~hudson/gettimeofday.c)
'lag' is sporadic and may take several iterations to come up.


Machine is 2xK7 with a ACPI C2 sleep driver (TSC's get unsynched).
2.5.72-mm3 didn't show these.

-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

