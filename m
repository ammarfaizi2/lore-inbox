Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131140AbRCQTDW>; Sat, 17 Mar 2001 14:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131734AbRCQTDM>; Sat, 17 Mar 2001 14:03:12 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:4586 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S131140AbRCQTDF>; Sat, 17 Mar 2001 14:03:05 -0500
Date: Sat, 17 Mar 2001 11:02:15 -0800
From: Andy Chou <acc@CS.Stanford.EDU>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org,
        mc@CS.Stanford.EDU
Subject: Re: [CHECKER] 120 potential dereference to invalid pointers errors for linux 2.4.1
Message-ID: <20010317110215.A21529@Xenon.Stanford.EDU>
Reply-To: acc@CS.Stanford.EDU
In-Reply-To: <Pine.GSO.4.31.0103170126540.14147-100000@elaine24.Stanford.EDU> <20010317043154.B67406@sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.1i
In-Reply-To: <20010317043154.B67406@sfgoth.com>; from mitch@sfgoth.com on Sat, Mar 17, 2001 at 04:31:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [BUG] fore200e_kmalloc can return NULL
> > /u2/acc/oses/linux/2.4.1/drivers/atm/fore200e.c:2032:fore200e_get_esi: ERROR:NULL:2020:2032: Using unknown ptr "prom" illegally! set by 'fore200e_kmalloc':2020
> 
> I don't see the bug - there is an explicit "if(!prom) return -ENOMEM;" after
> the allocation.  It looks fine to me.

We checked 2.4.1; it appears that by 2.4.2 someone had already fixed it :)

-Andy
