Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbTACISp>; Fri, 3 Jan 2003 03:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbTACISp>; Fri, 3 Jan 2003 03:18:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52418 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267467AbTACISo>;
	Fri, 3 Jan 2003 03:18:44 -0500
Date: Fri, 03 Jan 2003 00:19:34 -0800 (PST)
Message-Id: <20030103.001934.53526407.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, sfr@canb.auug.org.au,
       rth@twiddle.net, rmk@arm.linux.org.uk, bjornw@axis.com,
       davidm@hpl.hp.com, geert@linux-m68k.org, ralf@gnu.org, paulus@samba.org,
       anton@samba.org, schwidefsky@de.ibm.com, gniibe@m17n.org,
       kkojima@rr.iij4u.or.jp, ak@suse.de
Subject: Re: [PATCH] extable cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030103082410.94B0E2C275@lists.samba.org>
References: <20030103082410.94B0E2C275@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Fri, 03 Jan 2003 19:07:28 +1100

   Fairly straightforward consolidation of extable handling.  Sparc64 is
   trickiest, with its extable range stuff (ideally, the ranges would be
   in a separate __extable_range section, then the extable walking code
   could be made common, too).

I'm fine with this.
