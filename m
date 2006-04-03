Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWDCG3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWDCG3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 02:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWDCG3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 02:29:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6575
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751577AbWDCG3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 02:29:50 -0400
Date: Sun, 02 Apr 2006 23:29:33 -0700 (PDT)
Message-Id: <20060402.232933.01462994.davem@davemloft.net>
To: davej@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [IPSEC]: Kill unused decap state argument
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060403043134.GA7173@redhat.com>
References: <200604022014.k32KE6LH011600@hera.kernel.org>
	<20060403043134.GA7173@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Sun, 2 Apr 2006 23:31:34 -0500

> This breaks SELinux compilation.
> security/selinux/xfrm.c: In function 'selinux_socket_getpeer_dgram':
> security/selinux/xfrm.c:284: error: 'struct sec_path' has no member named 'x'
> security/selinux/xfrm.c: In function 'selinux_xfrm_sock_rcv_skb':
> security/selinux/xfrm.c:317: error: 'struct sec_path' has no member named 'x'
> 
> Does this look sane ?

Yes it does, thanks Dave.
