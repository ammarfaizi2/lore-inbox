Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290899AbSASBlh>; Fri, 18 Jan 2002 20:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290900AbSASBlR>; Fri, 18 Jan 2002 20:41:17 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:6528 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S290899AbSASBlO>; Fri, 18 Jan 2002 20:41:14 -0500
Date: Sat, 19 Jan 2002 02:41:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: James Cleverdon <jamesclv@us.ibm.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, Robert Love <rml@tech9.net>,
        Barry Wu <wqb123@yahoo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: how many cpus can linux support for SMP?
In-Reply-To: <200201190030.g0J0UYq11751@butler1.beaverton.ibm.com>
Message-ID: <Pine.GSO.3.96.1020119023636.6281A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, James Cleverdon wrote:

> > Pentium 4 APICs have addressing up to 255 IIRC, so they can do more
> > than P-III's 15.
> 
> Yup.  xAPICs (and SAPICs for IA64) are the only ones that can get beyond 14 
> (0x0F is the broadcast ID) using physical addressing.  I'm kicking around 
> some patches that use physical mode on a xAPIC NUMA box.

 Note that the original i82489DX supported up to 255 APICs (0xff being the
broadcast ID), so that's really nothing new and xAPICs are not the only
ones.  Of course, i82489DX provides 32-bits for addressing in the logical
mode. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

