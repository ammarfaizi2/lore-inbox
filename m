Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbTGCW7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265518AbTGCW6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:58:37 -0400
Received: from [66.212.224.118] ([66.212.224.118]:23564 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265504AbTGCW6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:58:20 -0400
Date: Thu, 3 Jul 2003 19:01:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       Boszormenyi Zoltan <zboszor@freemail.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
In-Reply-To: <20030703222651.GT26348@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0307031859170.5697@montezuma.mastecende.com>
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu>
 <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no>
 <20030703222651.GT26348@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003, William Lee Irwin III wrote:

> > Starting migration thread for cpu 0
> > Bringing up 1
> > CPU 1 IS NOW UP!
> > Starting migration thread for cpu 1
> > CPUS done 2
> > mtrr: v2.0 (20020519)
> > I never get a CPU 2 IS NOW UP (or CPU 0)

You never get "CPU 0 IS NOW UP", and you don't have 3 processors so you 
wouldn't see "CPU 2 IS NOW UP". Just cat /proc/cpuinfo or /proc/interrupts 
to verify processor count.

> Could you #define APIC_DEBUG to 1 in include/asm-i386/apicdef.h and
> send me a full bootlog?
> 
> 
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
function.linuxpower.ca
