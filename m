Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271030AbTHGWFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271033AbTHGWFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:05:38 -0400
Received: from proibm3.portoweb.com.br ([200.248.222.108]:37765 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S271030AbTHGWFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:05:37 -0400
Date: Thu, 7 Aug 2003 19:07:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.0-test2-mm5
In-Reply-To: <20030807142807.3e4a284c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0308071905200.5090-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Aug 2003, Andrew Morton wrote:

> Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> >
> > PCI: Using configuration type 1
> > 
> > 
> >  Locked up solid there. Want more info ? 
> 
> doh.  I don't even know who to lart for that one!
> 
> Could you please boot with "initcall_debug" and then resolve the final
> couple of addresses in System.map?  That'll narrow it down.

Heck it works with initcall_debug:

Red Hat Linux release 7.3 (Valhalla)
Kernel 2.6.0-test2-mm5 on an i686

I tried again without initcall_debug and it doesnt: 

Starting migration thread for cpu 7
CPUS done 16
zapping low mappings.
mtrr: v2.0 (20020519)
Initializing RT netlink socket
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd26c, last bus=15
PCI: Using configuration type 1
....

What additional info you guys want? 

Full output of both with/without initcall_debug boot messages or?

Odd, odd. 

