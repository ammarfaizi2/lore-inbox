Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278968AbRKIN1Y>; Fri, 9 Nov 2001 08:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279903AbRKIN1P>; Fri, 9 Nov 2001 08:27:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2690 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279901AbRKIN1H>;
	Fri, 9 Nov 2001 08:27:07 -0500
Date: Fri, 09 Nov 2001 05:26:50 -0800 (PST)
Message-Id: <20011109.052650.104644078.davem@redhat.com>
To: smpcomputing@free.fr
Cc: alan@lxorguk.ukuu.org.uk, ak@suse.de, anton@samba.org, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <02e801c16920$9ca9acc0$0a01a8c0@beawrk10>
In-Reply-To: <E162BFV-0002y1-00@the-village.bc.nu>
	<20011109.045455.74749430.davem@redhat.com>
	<02e801c16920$9ca9acc0$0a01a8c0@beawrk10>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Philip Dodd" <smpcomputing@free.fr>
   Date: Fri, 9 Nov 2001 14:15:32 +0100

   > I think a boot time commandline option is more appropriate
   > for something like this.
   
   In the light of what was said about embedded systems, I'm not really sure a
   boot time option really is the way to go...

All the hash tables in question are allocated dynamically,
we size them at boot time, the memory is not consumed until
the kernel begins executing.  So a boottime option would be
just fine.

Franks a lot,
David S. Miller
davem@redhat.com
