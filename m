Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUGCPSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUGCPSo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 11:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUGCPSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 11:18:44 -0400
Received: from tag.witbe.net ([81.88.96.48]:47242 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265139AbUGCPSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 11:18:42 -0400
Message-Id: <200407031518.i63FIcX01117@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Chris Siebenmann'" <cks@utcc.utoronto.ca>
Cc: "'Linux Kernel mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux scheduler (scheduling) questions vs threads
Date: Sat, 3 Jul 2004 17:18:34 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRhBTJP8p+5dfFoTSq+ADm7XkrRHQAC7e8g
In-Reply-To: <40E6BB39.4080405@tmr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Chris Siebenmann wrote:
> > You write:
> > | Ingo Molnar wrote:
> > [...]
> > | > so the normal Linux scheduling policy applies to 
> 'threads' too. [...]
> > [...]
> > | On a multi-user machine this may result in undesirable 
> behaviour, since 
> > | each thread seems to compete for resources and the 
> machine may get VERY 
> > | slow if someone deos something anti-social.
> > 
> >  This is nothing unique to threads; the same problem appears if a
> > program (or a user) uses a bunch of CPU-eating processes. I imagine
> > that any real solution will have to be per-user 'beancounting' and
> > limits, which have yet to make it into the Linux kernel.
> 

What about ulimit'ing users ?

bash-2.05$ ulimit -a
core file size (blocks)     0
data seg size (kbytes)      unlimited
file size (blocks)          unlimited
max locked memory (kbytes)  unlimited
max memory size (kbytes)    unlimited
open files                  1024
pipe size (512 bytes)       8
stack size (kbytes)         8192
cpu time (seconds)          unlimited
max user processes          4087
virtual memory (kbytes)     unlimited

Regards,
Paul

