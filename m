Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUD3VAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUD3VAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUD3VAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:00:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:32920 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261273AbUD3Utn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:49:43 -0400
Date: Fri, 30 Apr 2004 13:44:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Boucher <marc@linuxant.com>
cc: "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <69A8B470-9AE6-11D8-B83D-000A95BCAC26@linuxant.com>
Message-ID: <Pine.LNX.4.58.0404301343140.18014@ppc970.osdl.org>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com>
 <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
 <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
 <Pine.LNX.4.58.0404301319020.18014@ppc970.osdl.org>
 <69A8B470-9AE6-11D8-B83D-000A95BCAC26@linuxant.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Apr 2004, Marc Boucher wrote:
> >
> > In other words, if driverloader was a stand-alone project, you could do
> > whatever the hell you wanted with it.
> 
> To clarify this important point, driverloader is a standalone project, 
> and structured similarly to the HSF driver (all os-specific code is 
> open-source allowing it to be used with any kernel or even 
> theoretically any other x86 operating system).

The Linux-centric parts are absolutely NOT stand-alone, and one big part
of that Linux-centric stuff is that magic line that says MODULE_LICENSE().

In other words, you're a weasel.

			Linus
