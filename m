Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbSKTM5d>; Wed, 20 Nov 2002 07:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266053AbSKTM5d>; Wed, 20 Nov 2002 07:57:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36966 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266043AbSKTM5c>; Wed, 20 Nov 2002 07:57:32 -0500
Date: Wed, 20 Nov 2002 08:04:22 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Steffen Persvold <sp@scali.com>, Jun Nakajima <jun.nakajima@intel.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] Xeon with HyperThreading and linux-2.4.20-rc2
Message-ID: <20021120080422.A1498@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0211201036170.13494-100000@sp-laptop.isdn.scali.no> <Pine.LNX.4.44.0211201236480.1139-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211201236480.1139-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Nov 20, 2002 at 12:53:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 12:53:04PM +0000, Hugh Dickins wrote:
> 
> I know too little to comment definitively, but it's my understanding
> that a dual HT machine should only show 2 processors in its MP table,
> their siblings only appearing through analysis of the ACPI tables.
> 
> Whether it's that your MP table has been wrongly set up, or that
> you've really been given 4 processors when you only asked for 2
> (sue your supplier!), I cannot say.  I've copied Jun at Intel
> and Arjan at RedHat, and hope they can shed more light on this.

Linux has zero problem with a sane MP table that lists all
CPU's. Intel normally seems to recommend against it (maybe N3.51 doesn't
like it or so) but it's all fair as far as I'm concerned.
The bios is supposed to offer you a choice
to disable hyperthreading, use that ;)

Greetings,
   Arjan van de Ven


-- 
But when you distribute the same sections as part of a whole which is a work 
based on the Program, the distribution of the whole must be on the terms of 
this License, whose permissions for other licensees extend to the entire whole,
and thus to each and every part regardless of who wrote it. [sect.2 GPL]
