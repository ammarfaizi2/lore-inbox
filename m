Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSJUFZE>; Mon, 21 Oct 2002 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264744AbSJUFZE>; Mon, 21 Oct 2002 01:25:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59436 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264743AbSJUFZD>; Mon, 21 Oct 2002 01:25:03 -0400
To: reneb@cistron.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re2: loadlin with 2.5.?? kernels
References: <1c6.531124.2ae44a91@aol.com>
	<5.1.0.14.2.20021020202108.00b890f8@pop.gmx.net>
	<slrnar60rv.8ud.reneb@orac.aais.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Oct 2002 23:29:27 -0600
In-Reply-To: <slrnar60rv.8ud.reneb@orac.aais.org>
Message-ID: <m1ptu4uzpk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Blokland <reneb@orac.aais.org> writes:

> In article <5.1.0.14.2.20021020202108.00b890f8@pop.gmx.net>, Mike Galbraith
> wrote:
> 
> 
> > What was the last version that booted for you no problem?  (other than size)
> > 
> >          -Mike
> 
> In my case x.38 that is the last, I don't no anymore why not .39 (did it
> compile?)
> But sure .40 didn't boot with loadlin and an image dd'd to a floppy

Hmm.  Are you certain the last working version wasn't at .30 that just before
Ingos gdt changes.  And changing the gdt is quite likely to have broken loadlin,
as it uses the segments in the gdt from setup.S

I will see if I can build a test patch for this.  Except for the recent EDD
work and the GDT change there really haven't been changes to setup.S so this
failure report is very strange.

Eric
