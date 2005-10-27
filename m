Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVJ0DvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVJ0DvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 23:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVJ0DvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 23:51:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40382 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964959AbVJ0DvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 23:51:01 -0400
Date: Wed, 26 Oct 2005 20:50:38 -0700
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: rajesh.shah@intel.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 1/1] export cpu_online_map
Message-Id: <20051026205038.26a1c333.pj@sgi.com>
In-Reply-To: <200510260421.j9Q4LGh9014087@shell0.pdx.osdl.net>
References: <200510260421.j9Q4LGh9014087@shell0.pdx.osdl.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew asked:
> - Why isn't set_cpus_allowed() just a no-op on UP?  Or some trivial thing
>   which tests for cpu #0?

I don't know.

By scanning random copies of kernels left on my drive, I can see that
it changed from a trivial "return 0" to the more interesting check using
cpu_online_map in one of your "linus.patch" patches in the release
2.6.11-rc1-mm2.

But I don't know how to get to the history at this point to see what
happened.

It looks like Linus started the git history at 2.6.12-rc2.

  Could someone clue me in on how to find Linux history BG (before-git)?

Since bk no longer works for me, I have no idea how to access any
history prior to about 2.6.12-rc2.  Ugh.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
