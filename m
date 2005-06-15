Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFOH6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFOH6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 03:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVFOH6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 03:58:06 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:26861 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261187AbVFOH6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 03:58:02 -0400
Date: Wed, 15 Jun 2005 09:57:04 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: "liyu@LAN" <liyu@ccoss.com.cn>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: one question about LRU mechanism
Message-ID: <20050615095704.558a2eb6@localhost>
In-Reply-To: <1118817991.5828.23.camel@liyu.ccoss.com.cn>
References: <1118812376.32766.4.camel@liyu.ccoss.com.cn>
	<20050615052530.GA3913@holomorphy.com>
	<1118817991.5828.23.camel@liyu.ccoss.com.cn>
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005 14:46:30 +0800
"liyu@LAN" <liyu@ccoss.com.cn> wrote:

> In 2.6.11.11, mm do not have function isolate_lru_pages(), but I
> downloaded linux-2.6.11.12.tar.bz2 source tarball, and apply follow two
> patches in order:
> 
> patch-2.6.12-rc6
> 2.6.12-rc6-mm1

"patch-2.6.12-rc6" applies to 2.6.11... not 2.6.11.X.

This is beacuse a new 2.6.11.X version can come out in any time before
2.6.12...

IOW a rule that says: "patch-2.6.X-rcZ applies to linux-2.6.(X-1)" is much
better than "patch-2.6.X-rcZ applies to
linux-2.6.(X-1).LAST_RELEASE_WHEN_THIS_RC_COME_OUT"

becose you don't have to dicover LAST_RELEASE_WHEN_THIS_RC_COME_OUT...

--
	Paolo Ornati
	Linux 2.6.12-rc6 on x86_64
