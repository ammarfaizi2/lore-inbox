Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264732AbRF2VOi>; Fri, 29 Jun 2001 17:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbRF2VO2>; Fri, 29 Jun 2001 17:14:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61350 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264652AbRF2VOU>;
	Fri, 29 Jun 2001 17:14:20 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15164.61353.233720.612481@pizda.ninka.net>
Date: Fri, 29 Jun 2001 14:14:17 -0700 (PDT)
To: Todd Sabin <tas@webspan.net>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bad TCP checksums in tcp_retrans_try_collapse 2.4.5pre5 (at least)
In-Reply-To: <m3pubnoz0v.fsf@jetcar.qnz.org>
In-Reply-To: <m3pubnoz0v.fsf@jetcar.qnz.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Todd Sabin writes:
 > Here's a patch against 2.4.5pre5 which should fix it:

Indeed, thanks for the fix.  I just double checked the other
csum_block_add calls in net/ipv4/tcp.c and they seem ok.

Later,
David S. Miller
davem@redhat.com
