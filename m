Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310441AbSCPRPN>; Sat, 16 Mar 2002 12:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310446AbSCPRPE>; Sat, 16 Mar 2002 12:15:04 -0500
Received: from bitmover.com ([192.132.92.2]:12676 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310441AbSCPROx>;
	Sat, 16 Mar 2002 12:14:53 -0500
Date: Sat, 16 Mar 2002 09:14:52 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Larry McVoy <lm@bitmover.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
Message-ID: <20020316091452.E10086@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Larry McVoy <lm@bitmover.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com> <3C9375B7.3070808@mandrakesoft.com> <20020316085213.B10086@work.bitmover.com> <3C937B82.60500@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C937B82.60500@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Mar 16, 2002 at 12:06:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 12:06:10PM -0500, Jeff Garzik wrote:
> This was just an example of a real world example that actually happened, 
> where BK sucked ass :)

Think file systems.  Think 2 file systems.  Think creating duplicate inodes
in the same place.  Now those 2 file systems are merged into a third, the
duplicates removed.  The original 2 still both exist and are both being
updated.  

> Marcelo's BK tree did not exist when I created my marcelo-2.4 tree. 
>  marcelo-2.4 repo existed for a while and people started using it.  Once 
> Marcelo appeared with his "official" BK tree, people naturally want to 
> migrate.  There were two migration paths: (1) export everything to GNU 
> patches, or (2) click the mouse 300 times.

There is a 3rd:  factor out the duplicates and and export/import only the
ones that Marcelo didn't have, then dump your tree and use his.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
