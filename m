Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265934AbTFVV41 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbTFVV41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 17:56:27 -0400
Received: from aneto.able.es ([212.97.163.22]:57083 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S265934AbTFVV40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 17:56:26 -0400
Date: Mon, 23 Jun 2003 00:10:29 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched.c gives ICE [Was: Re: web page on O(1) scheduler]
Message-ID: <20030622221029.GA2680@werewolf.able.es>
References: <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net> <16075.8557.309002.866895@napali.hpl.hp.com> <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net> <5.2.0.9.2.20030522114349.00cfd8f8@pop.gmx.net> <20030603205929.GC3661@werewolf.able.es> <20030622220324.GA2977@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.23, J.A. Magallon wrote:
> 
> On 06.03, J.A. Magallon wrote:
> > 
> [...]
> > 
> > Have you tried to build with gcc-3.3 ? I applied it on top of 2.4.x-aa,
> > and I just get an ICE:
> > 
> > End of search list.
> > sched.c: In function `do_schedule':
> > sched.c:1003: internal compiler error: in merge_assigned_reloads, at reload1.c:6134
> > Please submit a full bug report,
> > with preprocessed source if appropriate.
> > See <URL:https://qa.mandrakesoft.com/> for instructions.
> > 
> > sched.c::1003 is the closing brace for do_schedule().
> > 
> > Any idea ?
> > 
> 
> FYI, it was a gcc bug. In latest gcc release in mandrake:
> 
>  * Tue Jun 17 2003 Juan Quintela <quintela@trasno.org> 3.3-2mdk
> 
> - Add reload1 patch (fix bug http://gcc.gnu.org/bugzilla/show_bug.cgi?id=10890).
> 
> Now it builds fine with the patch attached.
> 

Ups,                                ^^^^^^^ == applied

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
