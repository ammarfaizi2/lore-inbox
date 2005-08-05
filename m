Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263063AbVHEP3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbVHEP3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVHEP2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:28:16 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:34725 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262418AbVHEP1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:27:12 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [PATCH] PNPACPI: fix IRQ and 64-bit address decoding
Date: Fri, 5 Aug 2005 09:27:03 -0600
User-Agent: KMail/1.8.1
Cc: matthieu castet <castet.matthieu@free.fr>, Adam Belay <ambx1@neo.rr.com>,
       Li Shaohua <shaohua.li@intel.com>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
References: <200508041726.19336.bjorn.helgaas@hp.com> <42F38324.10207@free.fr>
In-Reply-To: <42F38324.10207@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508050927.03303.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 August 2005 9:17 am, matthieu castet wrote:
> Bjorn Helgaas wrote:
> > The workaround
> > accepts stuff that is illegal according to the spec,
> > so speak up if you think this is a problem.
> > 
> May be print some warnings if the acpi is broken...

Yes, I thought about that, and in fact tried it out.  But
the warning wasn't very useful because we don't know which
device caused it.

We could restructure things to pass down that information,
but I thought the patch was getting large enough that I
should put that off for another day.
