Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVAGCQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVAGCQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 21:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVAGATN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:19:13 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:53948 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261399AbVAGAQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:16:48 -0500
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050106152621.395f935e.akpm@osdl.org>
References: <20050106190538.GB1618@us.ibm.com>
	 <1105039259.4468.9.camel@laptopd505.fenrus.org>
	 <20050106201531.GJ1292@us.ibm.com>
	 <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106210408.GM1292@us.ibm.com>
	 <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106152621.395f935e.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105053007.17176.291.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 23:11:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-06 at 23:26, Andrew Morton wrote:
> I think the exports should be restored.  So does Linus ("Not that I like it
> all that much, but I don't think we should break existing modules unless we
> have a very specific reason to break just those modules.").

What happens when the feature is just not (ab)usable in the way proposed
? 


