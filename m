Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSKEXeY>; Tue, 5 Nov 2002 18:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265352AbSKEXeX>; Tue, 5 Nov 2002 18:34:23 -0500
Received: from chunk.voxel.net ([207.99.115.133]:32732 "EHLO chunk.voxel.net")
	by vger.kernel.org with ESMTP id <S265351AbSKEXeV>;
	Tue, 5 Nov 2002 18:34:21 -0500
Date: Tue, 5 Nov 2002 18:40:58 -0500
From: Andres Salomon <dilinger@voxel.net>
To: Mike Diehl <mdiehl@dominion.dyndns.org>
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-announce] EVMS announcement
Message-ID: <20021105234058.GA28941@chunk.voxel.net>
References: <02110516191004.07074@boiler> <20021105214012.C2B4651CF@dominion.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105214012.C2B4651CF@dominion.dyndns.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux chunk 2.4.18-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note the difference between LVM (the tools, the on-disk format, etc) and
device-mapper (simply a generic interface in the kernel).  I suspect the
disasterous LVM experiences you've had were either with LVM1 (which did
not use device-mapper), or with some aspect of LVM2's userspace stuff
(which, I have yet to hear of any major problems with, other than
important features like pvmove not yet being implemented).  There's no
reason why EVMS would need to emulate similar behavior.


On Tue, Nov 05, 2002 at 04:00:10PM -0500, Mike Diehl wrote:
> 
> Well, I'm a bit disapointed.  My experience with LVM has been nothing short 
> of disasterous; EVMS looked like a very good alternative to LVM.  Volume 
> Management is one of the FEW things that Linux lacks that the "Big Boys" have.
> 
> 
> 
> 
> On Tuesday 05 November 2002 05:19 pm, Kevin Corry wrote:
>      > Greetings EVMS users,
>      >
>      > On behalf of the EVMS team, we would like to announce a significant
>      > change in direction for the Enterprise Volume Management System
>      > project.
[...]
>      > In summary, we feel that this decision is the best way to support our
>      > users for the long term. We want to provide EVMS on current and future
>      > kernels, and we feel this change provides the best method for
>      > achieving that. At the same time, this addresses all of the concerns
>      > voiced by the kernel community.  If anyone has any questions or
>      > concerns about this decision, please email us or the EVMS mailing list
>      > at
>      > evms-devel@lists.sf.net. We will be happy to answer any questions or
>      > discuss these changes in more detail.
>      >
>      > Thank you,
>      >
>      > The EVMS Team
>      > http://evms.sourceforge.net/
>      > evms-devel@lists.sourceforge.net
>      >
>      >
>      > -------------------------------------------------------
>      > This sf.net email is sponsored by: See the NEW Palm
>      > Tungsten T handheld. Power & Color in a compact size!
>      > http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
>      > _______________________________________________
>      > Evms-announce mailing list
>      > Evms-announce@lists.sourceforge.net
>      > To subscribe/unsubscribe, please visit:
>      > https://lists.sourceforge.net/lists/listinfo/evms-announce
> 
> -- 
> Mike Diehl
> PGP Encrypted E-mail preferred.
> Public Key via: http://dominion.dyndns.org/~mdiehl/mdiehl.asc
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
It's not denial.  I'm just selective about the reality I accept.
	-- Bill Watterson
