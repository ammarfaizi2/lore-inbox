Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRAONAZ>; Mon, 15 Jan 2001 08:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRAONAQ>; Mon, 15 Jan 2001 08:00:16 -0500
Received: from linuxcare.com.au ([203.29.91.49]:22024 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129718AbRAOM77>; Mon, 15 Jan 2001 07:59:59 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Mon, 15 Jan 2001 23:53:40 +1100
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        linux-mm@frodo.biederman.org
Subject: Re: Caches, page coloring, virtual indexed caches, and more
Message-ID: <20010115235340.B31461@linuxcare.com>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org> <m1snmlfbrx.fsf_-_@frodo.biederman.org> <20010115095432.A14351@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010115095432.A14351@bacchus.dhis.org>; from ralf@uni-koblenz.de on Mon, Jan 15, 2001 at 09:54:32AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
 
> At least for sparc it's already supported.  Right now I don't feel like
> looking into the 2.4 solution but checkout srmmu_vac_update_mmu_cache in
> the 2.2 kernel.

I killed that hack now that we align all shared mmaps to the same virtual
colour :)

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
