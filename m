Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUDNU6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUDNU6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:58:21 -0400
Received: from cpe-024-033-224-95.neo.rr.com ([24.33.224.95]:59780 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261742AbUDNU4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:56:01 -0400
Date: Wed, 14 Apr 2004 04:56:45 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.5
Message-ID: <20040414045645.GD12732@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20040414045552.GB12732@neo.rr.com> <20040414045622.GC12732@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414045622.GC12732@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Wed Apr 14 04:41:38 2004
+++ b/drivers/pnp/interface.c	Wed Apr 14 04:41:38 2004
@@ -434,7 +434,7 @@
 		goto done;
 	}
  done:
-	if (retval)
+	if (retval < 0)
 		return retval;
 	return count;
 }
