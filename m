Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbTIDLUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 07:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbTIDLUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 07:20:50 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:60626 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264906AbTIDLUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 07:20:50 -0400
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: nagendra_tomar@adaptec.com
Cc: Jamie Lokier <jamie@shareable.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309032134040.25093-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0309032134040.25093-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062674382.21667.32.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 12:19:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 17:07, Nagendra Singh Tomar wrote:
> In x86 store buffer is not snooped which leads to all these serialization 
> issues (other CPUs looking at stale value of data which is in the store 
> buffer of some other CPU).

x86 gives you coherency and store ordering (barring errata and special
CPU modes)

