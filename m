Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVCCVPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVCCVPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVCCVOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:14:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:61857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262589AbVCCVJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:09:41 -0500
Date: Thu, 3 Mar 2005 13:09:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: davej@redhat.com, davem@davemloft.net, jgarzik@pobox.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303130901.655cb9c4.akpm@osdl.org>
In-Reply-To: <20050303145846.GA5586@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com>
	<20050302162312.06e22e70.akpm@osdl.org>
	<42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<20050303011151.GJ10124@redhat.com>
	<20050302172049.72a0037f.akpm@osdl.org>
	<20050303012707.GK10124@redhat.com>
	<20050303145846.GA5586@pclin040.win.tue.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> API stability: Stable series like 2.0, 2.2, 2.4 try to maintain
>  the guarantee that user-visible APIs do not change. That goal
>  has disappeared, meaning that anything might break when one
>  upgrades from 2.6.14 to 2.6.16.
>  This is one of the big disadvantages of the new 2.6 way.

It depends on what you call a "user visible API".

Changes which are visible to userspace are treated with great caution
nowadays[*].  I keep on rejecting patches...

Changes which are visible to third-party kernel modules are more
acceptable, but we're still fairly reluctant to make them.

So I think you exaggerate.  And I don't see that the problem which you
describe is inevitably a part of the "new 2.6 way".




[*] I don't know any details of the /proc incompatibility which davej
    mentions, and I'd like to.  That sounds like a screw-up.
