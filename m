Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132402AbRAQFOC>; Wed, 17 Jan 2001 00:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132555AbRAQFNw>; Wed, 17 Jan 2001 00:13:52 -0500
Received: from linuxcare.com.au ([203.29.91.49]:47375 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S132402AbRAQFNo>; Wed, 17 Jan 2001 00:13:44 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 17 Jan 2001 15:36:47 +1100
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        linux-mm@frodo.biederman.org
Subject: Re: Caches, page coloring, virtual indexed caches, and more
Message-ID: <20010117153647.A7525@linuxcare.com>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org> <m1snmlfbrx.fsf_-_@frodo.biederman.org> <20010115095432.A14351@bacchus.dhis.org> <20010115235340.B31461@linuxcare.com> <20010115154124.A17336@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010115154124.A17336@bacchus.dhis.org>; from ralf@uni-koblenz.de on Mon, Jan 15, 2001 at 03:41:24PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Did you find any software that breaks due to the additional restriction
> on the virtual addresses of mappings?

Not yet. A good test of shared mmap coherency is a recent samba
(2.2 and above) that uses tdb. Tdb relies on shared mmaps heavily and
uncovered the bug when running on a dual ultrasparc pretty quickly.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
