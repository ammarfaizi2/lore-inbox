Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290789AbSBFUWn>; Wed, 6 Feb 2002 15:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290787AbSBFUWd>; Wed, 6 Feb 2002 15:22:33 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:49420 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S290789AbSBFUWT>;
	Wed, 6 Feb 2002 15:22:19 -0500
Date: Wed, 6 Feb 2002 13:21:44 -0700
From: yodaiken@fsmlabs.com
To: Jakub Jelinek <jakub@redhat.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
Message-ID: <20020206132144.A29162@hq.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <200202061258.g16CwGt31197@Port.imtp.ilyichevsk.odessa.ua.suse.lists.linux.kernel> <p73ofj2lpdg.fsf@oldwotan.suse.de> <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua> <20020206101231.X21624@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020206101231.X21624@devserv.devel.redhat.com>; from jakub@redhat.com on Wed, Feb 06, 2002 at 10:12:31AM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 10:12:31AM -0500, Jakub Jelinek wrote:
> Most sane architectures reserve a thread pointer register (%g6 resp. %g7 on
> sparc, tp on ia64, ppc will use %r2, alpha uses a fast pall call as thread
> "register", s390 uses user access register 0 (and s390x uar 0 and 1), etc.).
> On register starved ia32 there aren't too many spare registers, so %gs is
> used instead.

So the x86 designers have provided all sorts of shadow registers and extensive
high speed caches and the glibc developers deliberately choose to defeat all that
expensive optimization?

