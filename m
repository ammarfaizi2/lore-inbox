Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271606AbTG2MHB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271686AbTG2MHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:07:01 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:60399 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271606AbTG2MG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:06:56 -0400
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Kurt Wall <kwall@kurtwerks.com>,
       Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030729102007.GC1286@louise.pinerecords.com>
References: <1059396053.442.2.camel@lorien>
	 <20030728225017.GJ32673@louise.pinerecords.com>
	 <20030729002221.GD263@kurtwerks.com>
	 <20030729045512.GM32673@louise.pinerecords.com>
	 <20030729092857.GA28348@werewolf.able.es>
	 <20030729093521.GA1286@louise.pinerecords.com>
	 <20030729094820.GC28348@werewolf.able.es>
	 <20030729095858.GB1286@louise.pinerecords.com>
	 <20030729101126.GC29124@werewolf.able.es>
	 <20030729102007.GC1286@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059479661.3118.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 12:57:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-29 at 11:20, Tomas Szepe wrote:
> > What is the difference between backporting a patch from 3.3.1-pre to 3.3,
> > and using 3.3.1-pre directly ? Ah, that you get less bug corrected.
> 
> Large.  3.3 is a development series.  It DOES introduce new stuff.
> 
> In production environments you definitely want to stick with 3.2.3
> or (better yet) 2.95.3.

3.2 is probably the best, but lots of people are using gcc 3.3 to build
kernels and so far all the things we've hit have been the stricter
parser throwing up on technically invalid C in the kernel source/

