Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTABFOp>; Thu, 2 Jan 2003 00:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbTABFOp>; Thu, 2 Jan 2003 00:14:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38586 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265670AbTABFOo>;
	Thu, 2 Jan 2003 00:14:44 -0500
Date: Wed, 01 Jan 2003 21:15:36 -0800 (PST)
Message-Id: <20030101.211536.121172392.davem@redhat.com>
To: rth@twiddle.net
Cc: rusty@rustcorp.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ak@suse.de,
       paulus@samba.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH] Modules 3/3: Sort sections
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030101205836.A30574@twiddle.net>
References: <20030101205404.B30272@twiddle.net>
	<20030101.205003.37279830.davem@redhat.com>
	<20030101205836.A30574@twiddle.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Henderson <rth@twiddle.net>
   Date: Wed, 1 Jan 2003 20:58:36 -0800

   On Wed, Jan 01, 2003 at 08:50:03PM -0800, David S. Miller wrote:
   > I think this is to get .foo.init sections.
   
   Obviously.  Perhaps the question was worded badly.  Instead read
   it as "Why don't we force this to be called .init.foo instead?"

This new naming order was created recently, but I forget the reason.
It used to be .init.foo
