Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUCSCko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 21:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbUCSCko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 21:40:44 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:47924 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261468AbUCSCkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 21:40:43 -0500
Date: Thu, 18 Mar 2004 18:38:39 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040318183839.443a8cbe.pj@sgi.com>
In-Reply-To: <m37jxhvbgm.fsf@averell.firstfloor.org>
References: <1BeOx-7ax-55@gated-at.bofh.it>
	<1BgGq-DU-5@gated-at.bofh.it>
	<1BgZN-Vk-1@gated-at.bofh.it>
	<m37jxhvbgm.fsf@averell.firstfloor.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some wrappers would be prettier.

That's roughly what the mask.h is, along with enough other bits and
pieces so that it can serve as a complete basis for cpumasks and
nodemasks.  The bitmap.h stuff is an incomplete subset of what's
used.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
