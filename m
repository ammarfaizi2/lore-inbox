Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137107AbREKLRD>; Fri, 11 May 2001 07:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137111AbREKLQp>; Fri, 11 May 2001 07:16:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44183 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S137107AbREKLQQ>;
	Fri, 11 May 2001 07:16:16 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15099.51708.28196.783804@pizda.ninka.net>
Date: Fri, 11 May 2001 04:16:12 -0700 (PDT)
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Andi Kleen <ak@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Source code compatibility in Stable series????
In-Reply-To: <2983F527D00@vcnet.vc.cvut.cz>
In-Reply-To: <2983F527D00@vcnet.vc.cvut.cz>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr Vandrovec writes:
 > When I was updating VMware's vmnet, I decided to use
 > 
 > #ifdef skb_shinfo

No, don't use that, use MAX_SKB_FRAGS like the drivers do.
I guarentee to preserve that, whereas I reserve the right
to change the skb_shinfo implementation however I like.

Later,
David S. Miller
davem@redhat.com
