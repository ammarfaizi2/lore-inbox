Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbULTDsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbULTDsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 22:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbULTDsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 22:48:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64728 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261408AbULTDry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 22:47:54 -0500
Date: Sun, 19 Dec 2004 19:47:42 -0800
Message-Id: <200412200347.iBK3lg3X007599@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out CPU clock additions to posix-timers
In-Reply-To: Christoph Lameter's message of  Sunday, 19 December 2004 19:44:46 -0800 <Pine.LNX.4.58.0412191940310.1708@schroedinger.engr.sgi.com>
X-Zippy-Says: Do you guys know we just passed thru a BLACK HOLE in space?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since Andrew is taking the conservative line, I think it's more prudent to
omit the whole thing from 2.6.10 rather than have a tentative definition of
what those two clock IDs mean that changes later.  
