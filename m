Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271378AbTG2KUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271379AbTG2KUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:20:43 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:32141 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S271378AbTG2KUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:20:42 -0400
Date: Tue, 29 Jul 2003 12:20:07 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Kurt Wall <kwall@kurtwerks.com>,
       Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
Message-ID: <20030729102007.GC1286@louise.pinerecords.com>
References: <1059396053.442.2.camel@lorien> <20030728225017.GJ32673@louise.pinerecords.com> <20030729002221.GD263@kurtwerks.com> <20030729045512.GM32673@louise.pinerecords.com> <20030729092857.GA28348@werewolf.able.es> <20030729093521.GA1286@louise.pinerecords.com> <20030729094820.GC28348@werewolf.able.es> <20030729095858.GB1286@louise.pinerecords.com> <20030729101126.GC29124@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729101126.GC29124@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [jamagallon@able.es]
> 
> > Does Mandrake also ship "stable" distributions w/ kernels compiled using
> > gcc 3.3-whatever or is that idiocy suse-specific?
> 
> Tell me a distro that ships pristine www.kernel.org kernels o release
> gcc's, without any 'backported patch from xxx-1234 to correct PR1234'.

Slackware (whenever possible).

> What is the difference between backporting a patch from 3.3.1-pre to 3.3,
> and using 3.3.1-pre directly ? Ah, that you get less bug corrected.

Large.  3.3 is a development series.  It DOES introduce new stuff.

In production environments you definitely want to stick with 3.2.3
or (better yet) 2.95.3.

$ head -4 Makefile 
VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 22
EXTRAVERSION = -pre8
$ grep 'recommended compiler' Documentation/Changes 
The recommended compiler for the kernel is gcc 2.95.x (x >= 3), and it

> And no, at least in my case, this is not a stable Mandrake, it is Cooker,
> the equivalent of RawHide. Latest stable shiped a kernel built with 3.2.3,

Ok.

-- 
Tomas Szepe <szepe@pinerecords.com>
