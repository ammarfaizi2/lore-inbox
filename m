Return-Path: <linux-kernel-owner+w=401wt.eu-S932734AbWLZR0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbWLZR0l (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 12:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbWLZR0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 12:26:41 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:53797 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932734AbWLZR0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 12:26:40 -0500
Date: Tue, 26 Dec 2006 09:27:08 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Fabio Comolli <fabio.comolli@gmail.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: BUG: scheduling while atomic - Linux 2.6.20-rc2-ga3d89517
Message-Id: <20061226092708.93d8b1b0.randy.dunlap@oracle.com>
In-Reply-To: <20061226171531.GC7600@elf.ucw.cz>
References: <b637ec0b0612240553n28b252c4p4c1559da794e646c@mail.gmail.com>
	<87psa9z0wu.fsf@duaron.myhome.or.jp>
	<b637ec0b0612251102w2bb4a4c1ifc78df1193879c6f@mail.gmail.com>
	<20061226171531.GC7600@elf.ucw.cz>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Dec 2006 18:15:31 +0100 Pavel Machek wrote:

> Hi!
> 
> > some days and will let you know if the problem represents. Please note
> > that it happened only twice and I don't have any clue on how to
> > reproduce it.
> > 
> > I added Pavel and Rafael to CC-list because for the first time in at
> > least six months my laptop failed to resume after suspend-to-disk
> > (userland tools) with this kernel. Guys, do you think that this
> > failure could be related to this BUG?
> 
> everything is possible, but this one does not seem too likely. Is
> failure reproducible?

Ingo just posted a patch for this problem.

http://marc.theaimsgroup.com/?l=linux-kernel&m=116715139714252&w=2

---
~Randy
