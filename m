Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267272AbTGHMXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbTGHMXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:23:19 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:6110 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S267272AbTGHMXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:23:17 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Christian Axelsson <smiler@lanil.mine.nu>
Date: Tue, 8 Jul 2003 14:37:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-mailer: Pegasus Mail v3.50
Message-ID: <6A3BC5C5B2D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Jul 03 at 13:35, Christian Axelsson wrote:
> On Tue, 2003-07-08 at 13:23, Flameeyes wrote:
> > On Tue, 2003-07-08 at 13:01, Petr Vandrovec wrote:
> > > vmware-any-any-update35.tar.gz should work on 2.5.74-mm2 too.
> > > But it is not tested, I have enough troubles with 2.5.74 without mm patches...
> > vmnet doesn't compile:
> > 
> > make: Entering directory `/tmp/vmware-config1/vmnet-only'
> > In file included from userif.c:51:
> > pgtbl.h: In function `PgtblVa2PageLocked':
> > pgtbl.h:82: warning: implicit declaration of function `pmd_offset'
> > pgtbl.h:82: warning: assignment makes pointer from integer without a
> > cast
> > make: Leaving directory `/tmp/vmware-config1/vmnet-only'
> 
> I get exactly the same errors. BTW I got these on vanilla 2.5.74 aswell.

Either copy compat_pgtable.h from vmmon to vmnet, or grab
vmware-any-any-update36. I forgot to update vmnet's copy of this file.
                                                Petr Vandrovec
                                                

