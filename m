Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUJKHZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUJKHZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 03:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUJKHZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 03:25:22 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50406 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265222AbUJKHZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 03:25:17 -0400
Date: Mon, 11 Oct 2004 09:23:07 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <tj@home-tj.org>
Subject: via-velocity heads up (was (Re: Linux 2.6.9-rc4 - pls test (and no more patches))
Message-ID: <20041011072307.GA18577@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> :
[...]
> Summary of changes from v2.6.9-rc3 to v2.6.9-rc4
> ============================================
[...]
> Fran?ois Romieu:
>   o via-velocity: properly manage the count of adapters
>   o via-velocity: removal of unused velocity_info.xmit_lock
>   o via-velocity: velocity_give_rx_desc() removal
>   o via-velocity: received ring wrong index and missing barriers
>   o via-velocity: early invocation of init_cam_filter()
>   o via-velocity: removal of incomplete endianness handling
>   o via-velocity: wrong buffer offset in velocity_init_td_ring()
>   o via-velocity: comment fixes

The attribution is a bit misleading as Tejun Heo <tj@home-tj.org>
did the real work (he appears in the logs though).

People should really, really, test this code if they have been
experiencing issues with the driver lately.

Test reports welcome here or on netdev@oss.sgi.com.

--
Ueimor
