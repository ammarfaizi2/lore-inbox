Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760798AbWLHSEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760798AbWLHSEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 13:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760794AbWLHSEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:04:51 -0500
Received: from ns2.suse.de ([195.135.220.15]:48817 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426061AbWLHSEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:04:50 -0500
From: Andi Kleen <ak@suse.de>
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 19:04:33 +0100
User-Agent: KMail/1.9.5
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, linux-kernel@vger.kernel.org
References: <200612080401.25746.ak@suse.de> <20061208125107.GA3545@rhun.ibm.com> <200612081403.13404.arekm@maven.pl>
In-Reply-To: <200612081403.13404.arekm@maven.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081904.33205.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > >
> > > Something related (git tree fetched 1-2h ago) ?
> >
> > Probably. Please send your .config.
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.19
> # Fri Dec  8 11:40:15 2006
> #
> CONFIG_X86_32=y

I built your config and it builds fine here with gcc 4.1/binutils 2.17.50.0.5

What compiler version do you have?

_proxy_pda shouldn't be referenced at all -- it just a dummy to tell
the compiler about the side effects of the PDA operations.

-Andi

