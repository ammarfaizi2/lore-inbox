Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTIXRU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 13:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbTIXRU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 13:20:56 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:28808 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261546AbTIXRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 13:20:55 -0400
Date: Wed, 24 Sep 2003 12:55:59 -0400
From: Ben Collins <bcollins@debian.org>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [PATCH 2.4] ieee1394 locking bug in nodemgr
Message-ID: <20030924165559.GH718@phunnypharm.org>
References: <20030924164832.GB26237@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924164832.GB26237@master.mivlgu.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 08:48:32PM +0400, Sergey Vlasov wrote:
> Hello!
> 
> I have found a locking bug in ieee1394 nodemgr_host_thread() (in
> Linux 2.4.22; checked at linux.bkbits.net - the code in question did
> not change).

Good catch. Patch applied to all branches.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
