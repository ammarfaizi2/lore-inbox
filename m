Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbTCWXIv>; Sun, 23 Mar 2003 18:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263987AbTCWXIv>; Sun, 23 Mar 2003 18:08:51 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28472 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263986AbTCWXIu>; Sun, 23 Mar 2003 18:08:50 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303232319.h2NNJqs13257@devserv.devel.redhat.com>
Subject: Re: Ptrace hole / Linux 2.2.25
To: mbligh@aracnet.com (Martin J. Bligh)
Date: Sun, 23 Mar 2003 18:19:52 -0500 (EST)
Cc: jgarzik@pobox.com (Jeff Garzik), jbourne@mtroyal.ab.ca (James Bourne),
       linux-kernel@vger.kernel.org, rml@tech9.net (Robert Love),
       mj@ucw.cz (Martin Mares), alan@redhat.com (Alan Cox),
       skraw@ithnet.com (Stephan von Krawczynski), szepe@pinerecords.com,
       arjanv@redhat.com, pavel@ucw.cz (Pavel Machek)
In-Reply-To: <1240000.1048460079@[10.10.2.4]> from "Martin J. Bligh" at Mar 23, 2003 02:54:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> O(1) sched may be a bad example ... how about the fact that mainline VM
> is totally unstable? Witness, for instance, the buffer_head stuff. Fixes
> for that have been around for ages. 

On normal computers 2.4.21pre VM is very stable, in fact I dumped the
rmap vm from -ac because its far better at the moment

Most people don't care about 32 way scaling of 16Gb boxes running EVMS.
