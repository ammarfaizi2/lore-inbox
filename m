Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263995AbTCWXYH>; Sun, 23 Mar 2003 18:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbTCWXYH>; Sun, 23 Mar 2003 18:24:07 -0500
Received: from franka.aracnet.com ([216.99.193.44]:23211 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263995AbTCWXYC>; Sun, 23 Mar 2003 18:24:02 -0500
Date: Sun, 23 Mar 2003 15:34:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>, James Bourne <jbourne@mtroyal.ab.ca>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       Martin Mares <mj@ucw.cz>, Stephan von Krawczynski <skraw@ithnet.com>,
       szepe@pinerecords.com, arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <6510000.1048462494@[10.10.2.4]>
In-Reply-To: <200303232319.h2NNJqs13257@devserv.devel.redhat.com>
References: <200303232319.h2NNJqs13257@devserv.devel.redhat.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> O(1) sched may be a bad example ... how about the fact that mainline VM
>> is totally unstable? Witness, for instance, the buffer_head stuff. Fixes
>> for that have been around for ages. 
> 
> On normal computers 2.4.21pre VM is very stable, in fact I dumped the
> rmap vm from -ac because its far better at the moment

Cool - I gave up on 2.4 before that. Perhaps it's getting sorted out now
... is the buffer_head stuff fixed now? If 2.4 VM was more or less the same
across distros, that would get rid of a whole bunch of pain.

> Most people don't care about 32 way scaling of 16Gb boxes running EVMS.

That wasn't what I meant ... but I think there's a place for a tree
of common vendor 2.4 fixes & features, a separate one for the workstation
and server stuff if you will. All the current duplication of effort seems
rather silly.

M.
