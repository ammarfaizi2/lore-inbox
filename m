Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUKAKb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUKAKb3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 05:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUKAKb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 05:31:29 -0500
Received: from gyre.foreca.com ([193.94.59.26]:35032 "EHLO gyre.weather.fi")
	by vger.kernel.org with ESMTP id S261745AbUKAKb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 05:31:28 -0500
Date: Mon, 1 Nov 2004 12:31:14 +0200 (EET)
From: =?ISO-8859-1?Q?Jaakko_Hyv=E4tti?= <jaakko@hyvatti.iki.fi>
X-X-Sender: jaakko@gyre.weather.fi
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 and nfsd do not work under load (Re: x86_64, LOCKUP on
 CPU0, kjournald)
In-Reply-To: <20041101013150.2ab0aaa5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0411011226250.2172@gyre.weather.fi>
References: <Pine.LNX.4.58.0410260818560.3400@gyre.weather.fi>
 <Pine.LNX.4.58.0411010847180.2172@gyre.weather.fi> <20041101013150.2ab0aaa5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Andrew Morton wrote:
> Jaakko Hyvätti <jaakko@hyvatti.iki.fi> wrote:
> >
> >
> > Here is another oops and lockup, with nfsd now there in the trace also:
> >
> > Unable to handle kernel paging request at ffffffff00000808 RIP:
> > <ffffffff80161b37>{cache_alloc_refill+329}
> > PML4 103027 PGD 0
> > Oops: 0002 [1] SMP
> > CPU 0
> > Modules linked in: w83627hf i2c_sensor i2c_isa i2c_core nfsd exportfs lockd sunrpc md5 ipv6 parport_pc lp parport tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd 3w_xxxx sd_mod scsi_mod
> > Pid: 1968, comm: nfsd Not tainted 2.6.8-1.521smp
>
> That's a vendor kernel of some form, yes?

  Fedora core 2 latest, I assumed it is very close to kernel.org or even
the same kernel.  But I'll try 2.6.9 now.  It might take a week to oops
though.

Jaakko

-- 
Foreca Ltd                                           Jaakko.Hyvatti@foreca.com
Pursimiehenkatu 29-31 B, FIN-00150 Helsinki, Finland     http://www.foreca.com
