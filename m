Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbTDPSHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTDPSHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:07:32 -0400
Received: from mx02.cyberus.ca ([216.191.240.26]:26889 "EHLO mx02.cyberus.ca")
	by vger.kernel.org with ESMTP id S264497AbTDPSHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:07:31 -0400
Date: Wed, 16 Apr 2003 14:18:10 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Tomas Szepe <szepe@pinerecords.com>,
       Catalin BOIE <util@deuroconsult.ro>, "" <linux-kernel@vger.kernel.org>,
       "" <netdev@oss.sgi.com>, "" <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH] qdisc oops fix
In-Reply-To: <200304162003.06600.m.c.p@wolk-project.de>
Message-ID: <20030416140440.O5912@shell.cyberus.ca>
References: <20030415084706.O1131@shell.cyberus.ca>
 <20030416160606.GA32575@louise.pinerecords.com> <3E9D8A68.5050207@colorfullife.com>
 <200304162003.06600.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Apr 2003, Marc-Christian Petersen wrote:

> On Wednesday 16 April 2003 18:52, Manfred Spraul wrote:
>
> Hi Manfred,
>
> > >The original backtrace as provided by Martin Volf does not contain
> > >any weird addresses such as 0xd081ecc7 above:
> > >http://marc.theaimsgroup.com/?l=linux-kernel&m=105013596721774&w=2
> > Thanks.
> > The bug was caused by sch_tree_lock() in htb_change_class().
> > 2.4.21-pre7 contains a fix.
> am I just blind or isn't there a fix in -pre7|current-BK?
>

No you are not ;-> Yes, the fix for that specific problem is in
2.4.21-pre7. I think Tomas might have missed that we moved on to the
next problem.

cheers,
jamal
