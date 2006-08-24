Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbWHXVuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbWHXVuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWHXVuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:50:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25053 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030481AbWHXVut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:50:49 -0400
Subject: Re: Serial custom speed deprecated?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, David Woodhouse <dwmw2@infradead.org>,
       Stuart MacDonald <stuartm@connecttech.com>,
       linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0608241635090.13499@chaos.analogic.com>
References: <028a01c6c6fc$e792be90$294b82ce@stuartm>
	 <1156411101.3012.15.camel@pmac.infradead.org>
	 <m3bqqap09a.fsf@defiant.localdomain>
	 <1156441293.3007.184.camel@localhost.localdomain>
	 <m31wr6otlr.fsf@defiant.localdomain>
	 <Pine.LNX.4.61.0608241635090.13499@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 23:11:41 +0100
Message-Id: <1156457501.3007.193.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 16:43 -0400, ysgrifennodd linux-os (Dick Johnson):
> at 75 and increases by powers-of-two. This is because the hardware
> always had fixed clocks with dividers that divided by powers-of-two.
> What is the claim for the requirement of strange baud-rates set
> as an integer of dimension "baud?" Where does this requirement
> come from and what devices use these?

A lot of chips will do all sorts of interesting speeds such as 31.5Kbit
because today the clocks are themselves quite configurable.


