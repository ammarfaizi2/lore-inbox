Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRAORnB>; Mon, 15 Jan 2001 12:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129977AbRAORmw>; Mon, 15 Jan 2001 12:42:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:17912 "EHLO
	lappi.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S129729AbRAORml>; Mon, 15 Jan 2001 12:42:41 -0500
Date: Mon, 15 Jan 2001 15:41:24 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        linux-mm@frodo.biederman.org
Subject: Re: Caches, page coloring, virtual indexed caches, and more
Message-ID: <20010115154124.A17336@bacchus.dhis.org>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org> <m1snmlfbrx.fsf_-_@frodo.biederman.org> <20010115095432.A14351@bacchus.dhis.org> <20010115235340.B31461@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010115235340.B31461@linuxcare.com>; from anton@linuxcare.com.au on Mon, Jan 15, 2001 at 11:53:40PM +1100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2001 at 11:53:40PM +1100, Anton Blanchard wrote:

> > At least for sparc it's already supported.  Right now I don't feel like
> > looking into the 2.4 solution but checkout srmmu_vac_update_mmu_cache in
> > the 2.2 kernel.
> 
> I killed that hack now that we align all shared mmaps to the same virtual
> colour:)

Did you find any software that breaks due to the additional restriction
on the virtual addresses of mappings?

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
