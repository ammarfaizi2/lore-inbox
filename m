Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTIRKNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 06:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbTIRKNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 06:13:30 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:9398 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263050AbTIRKN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 06:13:29 -0400
X-Sender-Authentication: net64
Date: Thu, 18 Sep 2003 12:13:27 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: marcelo.tosatti@cyclades.com.br, pavel@ucw.cz, alan@lxorguk.ukuu.org.uk,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030918121327.5739b467.skraw@ithnet.com>
In-Reply-To: <20030918095845.GA77609@dspnet.fr.eu.org>
References: <20030916195345.GB68728@dspnet.fr.eu.org>
	<Pine.LNX.4.44.0309161814410.15569-100000@logos.cnet>
	<20030916212301.GC17045@m23.limsi.fr>
	<20030917131407.17f767a3.skraw@ithnet.com>
	<20030917130818.GA3144@m23.limsi.fr>
	<20030918095845.GA77609@dspnet.fr.eu.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Sep 2003 11:58:45 +0200
Olivier Galibert <galibert@pobox.com> wrote:

> On Wed, Sep 17, 2003 at 03:08:18PM +0200, Olivier Galibert wrote:
> > On Wed, Sep 17, 2003 at 01:14:07PM +0200, Stephan von Krawczynski wrote:
> > > Can you please give 2.4.23-pre4 a short test. I think I can see a
> > > remarkable difference tp 2.4.22 and would like to find confirmation ...
> > 
> > Well, I tried but the aic7xxx does not work for me, see other mail.
> > I'll try again once the LUN enumeration is fixed.
> 
> Actually I had booted the wrong kernel (2.6.0t4) by mistake.  SCSI
> works, and there is indeed a remarkable difference.  The system holds
> perfectly under filled-ram, high i/o usage now.  Excellent.

Fine. So we seem to agree 2.4.23 will be another big hit in the 2.4 line :-)
 
> Now if only the CPU enumeration worked and both CPUs were detected...

Hm, I have not yet seen any configuration where multiple CPUs are not detected.
Are you sure you have compiled in SMP support? What does dmesg look like?

Regards,
Stephan
