Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264683AbUDVV0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbUDVV0U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264684AbUDVV0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:26:20 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:35666 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264683AbUDVV0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:26:19 -0400
Date: Thu, 22 Apr 2004 22:26:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
In-Reply-To: <408822F1.80409@tmr.com>
Message-ID: <Pine.LNX.4.44.0404222221060.23593-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Bill Davidsen wrote:
> 
> I don't disagree on that, but it seems that KDE developers have put some 
> serious effort into making the software well-behaved, and unless there 
> is some measurable benefit from the code which negates the benefits of 
> that effort, it seems desirable to appreciate code code by letting it work.

2.6.6-rc2-mm1 does now have a "cmd: mremap moved N cows" kernel warning
of this inefficiency.  Please let us know if you see it in your log/dmesg,
when running KDE or whatever.  One sighting of 49 cows in xterm so far.

Thanks,
Hugh

