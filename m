Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbTIOU71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbTIOU71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:59:27 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:8326 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261615AbTIOU7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:59:24 -0400
Subject: Re: Monster file_lock_cache entry in /proc/slabinfo
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andrew Morton <akpm@osdl.org>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030915132514.0bee90bc.akpm@osdl.org>
References: <m3k78923wy.fsf@lugabout.jhcloos.org>
	 <20030915132514.0bee90bc.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063659560.2500.2.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Sep 2003 22:59:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-15 at 22:25, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm2/broken-out/file-locking-leak-fix.patch

Andrew, please replace that patch with

http://ftp.linux.org.uk/pub/linux/willy/patches/flock-memleak2.diff

Which is the second version of this bugfixing, it fixes this problem and
another leak. I can't reproduce any more leaks with this patch ontop of
-mm1.

-- 
/Martin
