Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUHWPeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUHWPeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUHWPbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:31:05 -0400
Received: from topaz-57.mcs.anl.gov ([140.221.57.209]:14208 "EHLO topaz")
	by vger.kernel.org with ESMTP id S264791AbUHWPYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:24:18 -0400
To: linux-kernel@vger.kernel.org
Subject: apm problem with mm series
From: Narayan Desai <desai@mcs.anl.gov>
Date: Mon, 23 Aug 2004 10:22:13 -0500
Message-ID: <87fz6dyj4q.fsf@topaz.mcs.anl.gov>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have started having problems resuming my laptop (a thinkpad t41p)
from apm-induced sleep. Suspension occurs after a longer period of
time than with working kernels, and resume never completes. the fans
come back on and the backlight turns on, but the system never
returns. It is unresponsive to sysrq keys, and eventually requires a
power cycle.  This problem started happening between 2.6.8-rc3-mm2 and
2.6.8.1-mm1. 2.6.8.1-mm4 still exhibits this problem. I am building
a vanilla 2.6.8.1 kernel now to try out now. I saw the issue with
yenta socket problems, so i disabled that support in the mm4 kernel,
to no avail. I realize that this isn't too much data to go on, but
would appreciate any suggestions.
 -nld
