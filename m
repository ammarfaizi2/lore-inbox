Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTLEWUS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTLEWUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:20:17 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.191]:9387 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id S264394AbTLEWUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:20:14 -0500
X-Biglobe-Sender: <slee@muf.biglobe.ne.jp>
Date: Sat, 06 Dec 2003 07:20:09 +0900
From: Stephen Lee <mukansai@emailplus.org>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Cc: Stephen Lee <mukansai@emailplus.org>, scott.feldman@intel.com,
       laforge@netfilter.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031205122819.25ac14ab.davem@redhat.com>
References: <20031204213030.2B75.MUKANSAI@emailplus.org> <20031205122819.25ac14ab.davem@redhat.com>
Message-Id: <20031206071129.D31D.MUKANSAI@emailplus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
> 
> OK, I've found out what IP conntack does that creates the problems.
> [...]
> People can confirm this analysis by applying the patch below, enabling
> TSO with conntrack loaded, and see if the problem goes away.

I tested it with both e1000 & tg3, TSO on, and it is working fine for me
using ftp and scp.

Thanks,
Stephen

