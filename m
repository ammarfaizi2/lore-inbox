Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWGZQMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWGZQMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWGZQMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:12:43 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:2218 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750892AbWGZQMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:12:42 -0400
Date: Wed, 26 Jul 2006 12:12:32 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: liyu <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
Subject: Re: [PATCH 1/3] usbhid: Driver for microsoft natural ergonomic keyboard 4000
Message-ID: <20060726161232.GC28284@filer.fsl.cs.sunysb.edu>
References: <44C74708.6090907@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C74708.6090907@ccoss.com.cn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+#define map_key(c) \
+       do { \
+               usage->code = c; \
+               usage->type = EV_KEY; \
+               set_bit(c,input->keybit); \
+       } while (0)

I'm not quite sure where usage is coming from. Some magical global variable?
Eeek.

Josef "Jeff" Sipek.

-- 
If I have trouble installing Linux, something is wrong. Very wrong.
		- Linus Torvalds
