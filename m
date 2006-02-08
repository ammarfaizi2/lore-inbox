Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWBHPPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWBHPPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWBHPPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:15:01 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:15594 "HELO farnsworth.org")
	by vger.kernel.org with SMTP id S1161084AbWBHPPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:15:00 -0500
Date: 8 Feb 2006 15:14:59 -0000
Message-ID: <20060208151459.16879.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: How in tarnation do I git v2.6.16-rc2?  hg died and I still don't
 git git
In-Reply-To: <20060208070301.1162e8c3.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20060208070301.1162e8c3.pj@sgi.com> Paul Jackson wrote:
> But how in tarnation do I git a checked out copy/clone/whatever of
> Linus's tree that only has the changes up through revision v2.6.16-rc2
> (that doesn't include changes since then)?

git-clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
cd linux-2.6
git-checkout -b v2.6.16-rc2 v2.6.16-rc2
