Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277599AbRJHXLh>; Mon, 8 Oct 2001 19:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277600AbRJHXL1>; Mon, 8 Oct 2001 19:11:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63878 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277599AbRJHXLN>;
	Mon, 8 Oct 2001 19:11:13 -0400
Date: Mon, 08 Oct 2001 16:08:54 -0700 (PDT)
Message-Id: <20011008.160854.08322122.davem@redhat.com>
To: dwmw2@infradead.org
Cc: frival@zk3.dec.com, paulus@samba.org, Martin.Bligh@us.ibm.com,
        alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, jay.estabrook@compaq.com,
        rth@twiddle.net
Subject: Re: [PATCH] change name of rep_nop 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <14658.1002582388@redhat.com>
In-Reply-To: <15294.24873.866942.423260@cargo.ozlabs.ibm.com>
	<13962.1002580586@redhat.com>
	<14658.1002582388@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Woodhouse <dwmw2@infradead.org>
   Date: Tue, 09 Oct 2001 00:06:28 +0100
   
   It's not just mtrr stuff, and it's not just arch-specific code either. In
   some cases, there is a need for a function which actually does flush the
   cache.

Example of this on ix86?

Regardless, the purpose of the cachetlb.txt interfaces is for the
generic VM subsystem of the kernel.  Nothing more.  If AGP, mtrr,
whatever weird device stuff needs this, it belongs in a different
area.

Franks a lot,
David S. Miller
davem@redhat.com
