Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVCHTN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVCHTN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVCHTN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:13:28 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:52680 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261555AbVCHTLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:11:14 -0500
Date: Tue, 08 Mar 2005 14:11:20 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
In-reply-to: Your message of "Tue, 08 Mar 2005 13:55:55 EST."
 <1110308156.4401.4.camel@mindpipe>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, mpm@selenic.com, joq@io.com,
       cfriesen@nortelnetworks.com, Chris Wright <chrisw@osdl.org>,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Message-id: <200503081911.j28JBL4D014012@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And as I mentioned a few times, the authors have neither the inclination
>nor the ability to do that, because they are not kernel hackers.  The
>realtime LSM was written by users (not developers) of the kernel, to
>solve a specific real world problem.  No one ever claimed it was the
>correct solution from the kernel POV.

i would just like to add that its very disappointing that the LSM,
having been included in the kernel (apparently very much against
Christoph's and others' advice) turns out to be so useless. from
outside lkml, LSM appeared to be a mechanism to allow
non-kernel-developers to create new security policies (perhaps even
mechanisms) without trying to tackle the entire kernel. instead, we
are now getting a fix which, while it solves the same problem, has
required substantive analysis of its effect on the overall kernel, and
will require continued vigilance to ensure that it doesn't now or
later cause unintended side effects. LSM appeared to be the "right"
way to do this in terms of modularity - it is disappointing to find it
has so little support (close to zero to judge from this debate) on
LKML despite being present in the kernel.

--p

