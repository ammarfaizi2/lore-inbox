Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130875AbRBCBPy>; Fri, 2 Feb 2001 20:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130874AbRBCBPf>; Fri, 2 Feb 2001 20:15:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:62980 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129048AbRBCBPL>; Fri, 2 Feb 2001 20:15:11 -0500
Message-ID: <3A7B5B84.A6A3211E@transmeta.com>
Date: Fri, 02 Feb 2001 17:14:44 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Richard Gooch <rgooch@atnf.csiro.au>, linux-kernel@vger.kernel.org
Subject: Re: CPU capabilities -- an update proposal
In-Reply-To: <Pine.LNX.4.21.0102022217350.7240-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> I wonder (you or hpa may very quickly point out why this is stupid
> and impossible), could we move the identify_cpu() calls into
> cpu_init()?  I used to think it was called too early for that, but
> now I see it's already using current, smp_processor_id(), printk().
> 

I like that idea.  I think it would clean up a lot of crud.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
