Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVCJKBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVCJKBK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 05:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVCJKBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 05:01:10 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:27575 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262489AbVCJKBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 05:01:06 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Greg KH <greg@kroah.com>
Date: Thu, 10 Mar 2005 21:00:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16944.6867.858907.990990@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] -stable, how it's going to work.
In-Reply-To: message from Greg KH on Tuesday March 8
References: <20050309072833.GA18878@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 8, greg@kroah.com wrote:
> So here's a first cut at how this 2.6 -stable release process is going
> to work that Chris and I have come up with.  Does anyone have any
> problems/issues/questions with this?

One rule that I thought would make sense, but that I don't see listed
is:

 - must fix a regression

If some problem was in 2.6.X and is still there in 2.6.X+1, then there
is no great rush to fix it for 2.6.(X+1).1, it can wait for 2.6.(X+2).

Security issues could be an exception to this, or it could be seen
that the publication of a security vulnerability causes a regression
which needs to be fixed...

NeilBrown
