Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293386AbSCJX4K>; Sun, 10 Mar 2002 18:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293390AbSCJX4A>; Sun, 10 Mar 2002 18:56:00 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:23812
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S293386AbSCJXzv>; Sun, 10 Mar 2002 18:55:51 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <197603031558.G23FwZY05020@www.hockin.org>
Subject: Re: [PATCH] syscall interface for cpu affinity
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 3 Mar 1976 07:58:35 -0800 (PST)
Cc: rml@tech9.net (Robert Love), aj@suse.de (Andreas Jaeger),
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C8BF015.606BCCDA@mandrakesoft.com> from "Jeff Garzik" at Mar 10, 2002 06:45:25 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anon!  But there is something uber-ugly about constantly jamming more
> and more stuff into procfs without thinking or planning long term...  I
> vote for the non-procfs approach :)

At some point I had done a port of SGI's pset/sysmp interface to linux 2.2.
As far as I know, lots of people are still using it.  I haven't ported it
to 2.4 for various reasons, but I have to say - IT IS A MUCH BETTER
INTERFACE than all these ad-hoc cpus_allowed bits.

If I thought that it had a chance of inclusion, maybe I'd port it up, but
last I heard none of the "core" people wanted it.

If we are going to pick an affinity system, please, let's consider sysmp().

Tim

