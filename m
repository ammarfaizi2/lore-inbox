Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUGKLJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUGKLJP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 07:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUGKLJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 07:09:14 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:39616 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266561AbUGKLJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 07:09:12 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Voluntary Kernel Preemption Patch
Date: Sun, 11 Jul 2004 13:18:25 +0200
User-Agent: KMail/1.5
Cc: ck kernel mailing list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org
References: <20040709182638.GA11310@elte.hu> <20040711064730.GA11254@elte.hu> <cone.1089529187.633082.20820.502@pc.kolivas.org>
In-Reply-To: <cone.1089529187.633082.20820.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407111318.25065.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 of July 2004 08:59, Con Kolivas wrote:
> Ingo Molnar writes:
> > * Con Kolivas <kernel@kolivas.org> wrote:
> >> Ooops forgot to mention this was running reiserFS 3.6 on software
> >> raid0 2x IDE with cfq elevator.
> >
> > ok, reiserfs (and all journalling fs's) definitely need a look - as you
> > can see from the ext3 mods in the patch. Any chance you could try ext3
> > based tests? Those are the closest to my setups.
>
> Sorry, I only have one machine to my name and I have to share it with
> both the family and testing so no such luck.

Well, I'm now only working on some documentation, so I think I can run some 
tests if they are automated enough, on either i686 or x86-64 machine (both 
SMP).  There's about 5 - 10 GB of free disk space on each (ext3, but I can 
create a reiserfs easily, if needed).

If you want me to do this, please provide me with:
a) patches to test,
b) benchmark tools,
c) instructions (what to turn on/off in the kernel config, how to run the 
benchmarks - I need to be able to use a text editor while they are running 
and occasionally run a web browser or acroread, but I don't care much if the 
system crashes on them).

Yours,
rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
