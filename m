Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318201AbSG2WdU>; Mon, 29 Jul 2002 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318202AbSG2WdU>; Mon, 29 Jul 2002 18:33:20 -0400
Received: from jalon.able.es ([212.97.163.2]:4589 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318201AbSG2WdT>;
	Mon, 29 Jul 2002 18:33:19 -0400
Date: Tue, 30 Jul 2002 00:35:39 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: oopsen with rc3-aa3
Message-ID: <20020729223539.GA1936@714-cm.cps.unizar.es>
References: <20020729174238.GA1919@714-cm.cps.unizar.es> <20020729181020.GU1201@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020729181020.GU1201@dualathlon.random>; from andrea@suse.de on lun, jul 29, 2002 at 20:10:20 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20020729 Andrea Arcangeli wrote:
> On Mon, Jul 29, 2002 at 07:42:38PM +0200, J.A. Magallon wrote:
> > Hi.
> > 
> > The new code in rc3aa3 makes a dual Xeon box hang on boot just
> > when stating migration threads. I get two simultaneous oops, one
> > for migration_thread=1 and =2. Decoded oops for one of them:
> 
> can you find out the exact line of C code that oopses (i.e. what it is
> supposed to be edx)? If you can't find it please send me the disassembly
> of the function load_balance, thanks.
> 

Assembler listing for load_balance attached, got by objdump -d in
/usr/src/linux/vmlinux (correct procedure ?).

> Also please try to reproduce with Ingo's latest, I merged a few fixes
> for the migration thread startup from his latest update.
>

Does this mean I can merge Ingo's updates in -aa ? Don't they use any
infrastructure not present in 2.4 ?

TIA

