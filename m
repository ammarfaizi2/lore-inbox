Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbSJEWKe>; Sat, 5 Oct 2002 18:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262707AbSJEWKe>; Sat, 5 Oct 2002 18:10:34 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:65417
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S262702AbSJEWKd>; Sat, 5 Oct 2002 18:10:33 -0400
Date: Sat, 5 Oct 2002 18:24:51 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Jos Hulzink <josh@stack.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: some results...
Message-ID: <20021005182451.B15663@animx.eu.org>
References: <20021005214508.IKVD1253.amsfep12-int.chello.nl@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20021005214508.IKVD1253.amsfep12-int.chello.nl@there>; from Jos Hulzink on Sat, Oct 05, 2002 at 11:45:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First one reaction: Whoooow this kernel boots / responds fast ! Nice job 
> guys! No need to update this Dual PII 333 for the next century :)
> 
> Anyway. It boots and runs, only "scheduling while atomic" sounds very bad to 
> me. Furthermore the famous Debug: sleeping function called from illegal 
> context at slab.c:1374 and friends, I think you have seen most of them 
> already.
> 
> I marked all places I found odd with "^^^^^" search for those and you'll find 
> them. If any of these is new, please let me know, I'll provide details / test 
> results on demand.
> 
> Uptime is half an hour now, no ide problems yet. Time to stress the bitch. 
> Unfortunately I'm out of CD-rw's so no burning tests for the weekend.
> 
> I'm impressed, and back in the 2.5 testing business.

I can't get it to compile for me.  ide and serial both bomb out.  I'm
compiling as a module for both of these (I was going to test on an nfs
root/netboot machine and I modularize EVERYTHING! =)

If you want my .config and errors, I'll send them.  There was a few things I
changed in the source to get it to compile (serial was ok after removing an
#if test) and ide had unresolved symbols (ide being a few ide modules)

I'm not at that machine at this time and have no access to it (but will
later today).
