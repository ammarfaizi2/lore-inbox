Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbRAPKPE>; Tue, 16 Jan 2001 05:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbRAPKOy>; Tue, 16 Jan 2001 05:14:54 -0500
Received: from slc92.modem.xmission.com ([166.70.9.92]:30221 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129859AbRAPKOk>; Tue, 16 Jan 2001 05:14:40 -0500
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-kernel@vger.kernel.org,
        linux-mm@frodo.biederman.org
Subject: Re: Caches, page coloring, virtual indexed caches, and more
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org> <m1snmlfbrx.fsf_-_@frodo.biederman.org> <20010115095432.A14351@bacchus.dhis.org> <20010115235340.B31461@linuxcare.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Jan 2001 02:34:39 -0700
In-Reply-To: Anton Blanchard's message of "Mon, 15 Jan 2001 23:53:40 +1100"
Message-ID: <m1itnfg7rk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@linuxcare.com.au> writes:

>  
>  
> > At least for sparc it's already supported.  Right now I don't feel like
> > looking into the 2.4 solution but checkout srmmu_vac_update_mmu_cache in
> > the 2.2 kernel.
> 
> I killed that hack now that we align all shared mmaps to the same virtual
> colour :)

Nice.

Where do you do this?  And how do you handle the case of aliases with kseg,
the giant kernel mapping.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
