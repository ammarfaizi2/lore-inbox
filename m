Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279902AbRKIN0e>; Fri, 9 Nov 2001 08:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279903AbRKIN0Z>; Fri, 9 Nov 2001 08:26:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:386 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279902AbRKIN0K>;
	Fri, 9 Nov 2001 08:26:10 -0500
Date: Fri, 09 Nov 2001 05:25:54 -0800 (PST)
Message-Id: <20011109.052554.41631501.davem@redhat.com>
To: ak@suse.de
Cc: alan@lxorguk.ukuu.org.uk, anton@samba.org, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011109141755.A30575@wotan.suse.de>
In-Reply-To: <E162BFV-0002y1-00@the-village.bc.nu>
	<20011109.045455.74749430.davem@redhat.com>
	<20011109141755.A30575@wotan.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 9 Nov 2001 14:17:55 +0100

   Fine if you don't mind an indirect function call pointer somewhere in the TCP
   hash path.
   
The hashes are sized at boot time, we can just reduce
the size when the boot time option says "small machine"
or whatever.

Why in the world do we need indirection function call pointers
in TCP to handle that?

Franks a lot,
David S. Miller
davem@redhat.com
