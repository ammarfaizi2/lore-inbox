Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271413AbTG2Mev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbTG2Mev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:34:51 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:30796 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S271413AbTG2Meu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:34:50 -0400
Date: Tue, 29 Jul 2003 08:34:25 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Kurt Wall <kwall@kurtwerks.com>,
       Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
Message-ID: <20030729083425.O1336@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1059396053.442.2.camel@lorien> <20030728225017.GJ32673@louise.pinerecords.com> <20030729002221.GD263@kurtwerks.com> <20030729045512.GM32673@louise.pinerecords.com> <20030729092857.GA28348@werewolf.able.es> <20030729093521.GA1286@louise.pinerecords.com> <20030729094820.GC28348@werewolf.able.es> <20030729095858.GB1286@louise.pinerecords.com> <20030729101126.GC29124@werewolf.able.es> <20030729102007.GC1286@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030729102007.GC1286@louise.pinerecords.com>; from szepe@pinerecords.com on Tue, Jul 29, 2003 at 12:20:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 12:20:07PM +0200, Tomas Szepe wrote:
> > What is the difference between backporting a patch from 3.3.1-pre to 3.3,
> > and using 3.3.1-pre directly ? Ah, that you get less bug corrected.
> 
> Large.  3.3 is a development series.  It DOES introduce new stuff.

That's incorrect. gcc-3_3-branch is stable branch, the difference between
3.3 and 3.3.1-pre is mostly bugfixes. Of course, some new things appear
on the branch from time to time, but it is very different from GCC trunk
where development occurs.
gcc-3_2-branch does not introduce any new stuff, since similarly
to gcc-2_95-branch is dead (only gcc-3_2-rhl8-branch is maintained still).

	Jakub
