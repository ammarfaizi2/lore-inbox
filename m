Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291391AbSAaXA5>; Thu, 31 Jan 2002 18:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291389AbSAaXAs>; Thu, 31 Jan 2002 18:00:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6528 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291386AbSAaXAe>;
	Thu, 31 Jan 2002 18:00:34 -0500
Date: Thu, 31 Jan 2002 14:59:04 -0800 (PST)
Message-Id: <20020131.145904.41634460.davem@redhat.com>
To: vandrove@vc.cvut.cz
Cc: torvalds@transmeta.com, garzik@havoc.gtf.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
 not
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020131225306.GA23758@vana.vc.cvut.cz>
In-Reply-To: <107F105A2B71@vcnet.vc.cvut.cz>
	<20020131153115.A5370@havoc.gtf.org>
	<20020131225306.GA23758@vana.vc.cvut.cz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Petr Vandrovec <vandrove@vc.cvut.cz>
   Date: Thu, 31 Jan 2002 23:53:06 +0100
   
      I'd like to ask architecture maintainers (especially ia64, PPC, Sparc 
   and Sparc64 maintainers) for verification that my changes did not break 
   anything... I tested only i386, but changes were obvious...

I'll test this out up after Linus releases a pre-patch with this
included.

As a side note, this thing is so tiny (less than 4K on sparc64!) so
why don't we just include it unconditionally instead of having all
of this "turn it on for these drivers" stuff?
