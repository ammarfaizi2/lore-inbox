Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTFQQP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 12:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264713AbTFQQP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 12:15:57 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:27778 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S261196AbTFQQP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 12:15:56 -0400
Message-Id: <200306171629.h5HGTiH9008541@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: berrymount.save/customers/marvel/compulead
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>,
       LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>
Subject: Re: gcc-3.2.2 miscompiles kernel 2.4.* O_DIRECT code ? 
In-Reply-To: Message from Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> 
   of "17 Jun 2003 16:01:32 +0200." <1055858491.588.3.camel@teapot.felipe-alfaro.com> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Tue, 17 Jun 2003 18:29:43 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Felipe Alfaro Solana wrote:
> On Tue, 2003-06-17 at 14:37, Rob van Nieuwkerk wrote:
> > Hi,
> > 
> > I found out that O_DIRECT does not work correctly on 2.4 kernels
> > compiled with the RH gcc-3.2.2-5 on RH9.  It is working fine with
> > kernels compiled with the RH gcc-2.96-113 on RH 7.3.
> 
> Could you please try with gcc 3.3? I had similar problems when compiling
> 2.5 kernels with gcc 3.2. Compiling them with gcc 3.3 or 2.96 fixed the
> problems.

I compiled a 2.4.21-ac1 kernel with the gcc-3.3-7 packages from RH
Rawhide.  This solves the problem: O_DIRECT working correctly again.

	greetings,
	Rob van Nieuwkerk
