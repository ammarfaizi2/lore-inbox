Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285196AbRLRVTZ>; Tue, 18 Dec 2001 16:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285193AbRLRVR7>; Tue, 18 Dec 2001 16:17:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55186 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285183AbRLRVRE>;
	Tue, 18 Dec 2001 16:17:04 -0500
Date: Tue, 18 Dec 2001 13:15:54 -0800 (PST)
Message-Id: <20011218.131554.84359165.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: kuznet@ms2.inr.ac.ru, Mika.Liljeberg@welho.com, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
Subject: Re: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011218211450.E13126@flint.arm.linux.org.uk>
In-Reply-To: <20011218210332.D13126@flint.arm.linux.org.uk>
	<20011218.131155.91757544.davem@redhat.com>
	<20011218211450.E13126@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Tue, 18 Dec 2001 21:14:50 +0000

   On Tue, Dec 18, 2001 at 01:11:55PM -0800, David S. Miller wrote:
   >    On Tue, Dec 18, 2001 at 11:29:06PM +0300, kuznet@ms2.inr.ac.ru wrote:
   >    > No doubts it still has broken misaligned access.
   >    
   >    You're way out of line with that comment.
   > 
   > Not necessarily Russell.  You have even told us on several occaisions
   > that the older ARMs simply cannot fix up unaligned loads/stores in
   > fact.
   
   It read as "Oh, it's ARM, that's your problem then".
   
If it was "your problem, so go away" why did I even bother posting a
patch for him to test out?

Franks a lot,
David S. Miller
davem@redhat.com
