Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWGMH4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWGMH4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWGMH4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:56:05 -0400
Received: from mailgate.terastack.com ([195.173.195.66]:2056 "EHLO
	uk-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S964838AbWGMH4D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:56:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Date: Thu, 13 Jul 2006 08:56:01 +0100
Message-ID: <89E85E0168AD994693B574C80EDB9C27043F5DEE@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Thread-Index: AcallTdA7BG1iV93QBKvmlJCUpvBPAAu7kaQ
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 12 Jul 2006 08:58:52 +0100
> "Andy Chittenden" <AChittenden@bluearc.com> wrote:
> 
> > I tried to install the linux-image-2.6.17-1-amd64-k8-smp 
> debian package
> > on a ASUS M2NPV-VM motherboard based system and it hung 
> during boot. The
> > last message on the console was:
> > 
> >  io scheduler cfq registered
> 
> Suggest you add initcall_debug to the kernel boot command 
> line.  That'll
> tell us which initcall got stuck.

I was only able to scrounge 5 minutes on this system this morning.
Here's the last few messages output with initcall_debug on:

Calling initcall .... init+0x0/0xc()
Calling initcall .... noop_init+0x0/0xc()
io scheduler noop registered
Calling initcall .... as_init+0x0/0x4f()
io scheduler anticipatory registered (default)
Calling initcall .... deadline_init+0x0/0x4f()
io scheduler deadline registered
Calling initcall .... cfq_init+0x0/0xcc()
io scheduler cfq registered
Calling initcall .... pci_init+0x0/0x2b()

What other info can I grab? (Although I have to fit in with that
system's production schedule so I may not be able to come back with that
until later on today/tomorrow).


-- 
Andy, BlueArc Engineering
  
