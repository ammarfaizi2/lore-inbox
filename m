Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263924AbTDPVcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 17:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTDPVcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 17:32:47 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:60126 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263924AbTDPVcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 17:32:46 -0400
Date: Wed, 16 Apr 2003 23:44:23 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: jamal <hadi@cyberus.ca>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Catalin BOIE <util@deuroconsult.ro>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] qdisc oops fix
Message-ID: <20030416214422.GM32575@louise.pinerecords.com>
References: <20030415084706.O1131@shell.cyberus.ca> <20030416160606.GA32575@louise.pinerecords.com> <3E9D8A68.5050207@colorfullife.com> <200304162003.06600.m.c.p@wolk-project.de> <20030416140440.O5912@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416140440.O5912@shell.cyberus.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [hadi@cyberus.ca]
> >
> > > >The original backtrace as provided by Martin Volf does not contain
> > > >any weird addresses such as 0xd081ecc7 above:
> > > >http://marc.theaimsgroup.com/?l=linux-kernel&m=105013596721774&w=2
> > > Thanks.
> > > The bug was caused by sch_tree_lock() in htb_change_class().
> > > 2.4.21-pre7 contains a fix.
> > am I just blind or isn't there a fix in -pre7|current-BK?
> >
> 
> No you are not ;-> Yes, the fix for that specific problem is in
> 2.4.21-pre7. I think Tomas might have missed that we moved on to the
> next problem.

Trouble is, the fix went in for already -pre5 (cset 1.930.3.5), so if you
only look at the pre6->pre7 changelog (like I did), you aren't likely to
find it.  8)

T.
