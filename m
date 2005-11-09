Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbVKIARv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbVKIARv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbVKIARu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:17:50 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:57814 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030450AbVKIARt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:17:49 -0500
Date: Tue, 8 Nov 2005 16:17:33 -0800
From: Paul Jackson <pj@sgi.com>
To: "Rohit, Seth" <rohit.seth@intel.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Cleanup of __alloc_pages
Message-Id: <20051108161733.0814c12b.pj@sgi.com>
In-Reply-To: <20051107174349.A8018@unix-os.sc.intel.com>
References: <20051107174349.A8018@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you're going to remove the early reclaim logic, then
lets also nuke the related apparatus: should_reclaim_zone()
and __GFP_NORECLAIM (which is used in a couple of pagemap.h
macros as well)?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
