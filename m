Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUIUQwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUIUQwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUIUQwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:52:34 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:51216 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267840AbUIUQwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:52:30 -0400
Date: Tue, 21 Sep 2004 18:49:38 +0200
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>,
       David Woodhouse <dwmw2@infradead.org>,
       "Cagle, John" <john.cagle@hp.com>,
       Christian Borntraeger <linux-kernel@borntraeger.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Torben Mathiasen <device@lanana.org>, linux-mtd@lists.infradead.org
Subject: Re: [Patch][RFC] conflicting device major numbers in devices.txt
Message-ID: <20040921164938.GQ4055@linux>
References: <C50AB9511EE59B49B2A503CB7AE1ABD108F82153@cceexc19.americas.cpqcorp.net> <1095580254.5065.172.camel@localhost.localdomain> <20040921092356.GD4055@linux> <200409211703.47188.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409211703.47188.arnd@arndb.de>
X-OS: Linux 2.6.5-7.108-default
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21 2004, Arnd Bergmann wrote:
> On Dienstag, 21. September 2004 11:23, Torben Mathiasen wrote:
> > s/390 dasd moved to major 94.
> > s/390 VM/ESA moved to major 95.
> > INFTL moved to major 96.
> 
> Actually, major 95 has never been used for VM minidisks or any other
> s390 block device in any 2.4 or 2.6 based distribution, because that
> driver was integrated into the dasd driver (it just uses a different
> access method on the same devices). You might want to document that
> this number is currently unused, even if it doesn't get assigned to
> any other driver.
>

So, what you're saying is that Major 95 is not used at all in real life? Then
I'll remove it from from the list completely during the my next push. Let me
know if there's a point in keeping it assigned even if its obsolete.

Torben
