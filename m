Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266112AbSLITmm>; Mon, 9 Dec 2002 14:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbSLITmm>; Mon, 9 Dec 2002 14:42:42 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:23784 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S266112AbSLITml>;
	Mon, 9 Dec 2002 14:42:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Arjan van de Ven <arjanv@redhat.com>, Matthew Wilcox <willy@debian.org>
Subject: Re: [ACPI] RE: [BK PATCH] ACPI updates
Date: Mon, 9 Dec 2002 12:45:07 -0700
User-Agent: KMail/1.4.3
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Arjan van de Ven <arjanv@redhat.com>,
       Hanno =?iso-8859-1?q?B=F6ck?= <hanno@gmx.de>,
       "Grover, Andrew" <andrew.grover@intel.com>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com> <20021209191252.N20336@parcelfarce.linux.theplanet.co.uk> <20021209141720.A11277@devserv.devel.redhat.com>
In-Reply-To: <20021209141720.A11277@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212091245.07770.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 December 2002 12:17 pm, Arjan van de Ven wrote:
> On Mon, Dec 09, 2002 at 07:12:52PM +0000, Matthew Wilcox wrote:
> > On Mon, Dec 09, 2002 at 02:09:04PM -0200, Marcelo Tosatti wrote:
> > > Which machines do not work without the new ACPI code?
> > 
> > hp's zx1-based ia64 machines (my personal interest..) 
> 
> That one doesn't boot without other major patches anyway...

Apart from ACPI, the non-ia64 patches required to boot a zx1
should be relatively small: some IRQ changes, support in
memmap_init for discontiguous memory, etc.

Having a newer ACPI in 2.4.x (it currently has 20011018!)
would make things much easier for ia64.
