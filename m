Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269198AbUJQQ0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269198AbUJQQ0v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269217AbUJQQW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:22:59 -0400
Received: from build.arklinux.osuosl.org ([128.193.0.51]:57324 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S269213AbUJQQUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:20:03 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.9rc2-mm4 oops
Date: Sun, 17 Oct 2004 18:14:59 +0200
User-Agent: KMail/1.7
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Len Brown <len.brown@intel.com>,
       acpi-devel@lists.sourceforge.net
References: <1096571653.11298.163.camel@cmn37.stanford.edu> <200410011633.10171.bjorn.helgaas@hp.com> <200410071431.20400.bjorn.helgaas@hp.com>
In-Reply-To: <200410071431.20400.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410171815.00274.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 October 2004 22:31, Bjorn Helgaas wrote:

> > I looked at all the callers of acpi_bus_register_driver(), and
> > they all look fine (except the hpet one I found yesterday).  But
> > maybe there's something I missed, or maybe the acpi_bus_drivers
> > list got corrupted somehow.
> >
> > If you don't load the floppy driver, is the system stable?
>
> Any update on all this?  I've tried to reproduce the problem on
> my Athlon box, but so far I've been unsuccessful.

Tried a couple of boxes (with versions up to 2.6.9-rc4-mm1), it appears to be 
100% reproducable on boxes that don't have a floppy drive while it works ok 
on boxes that do have a floppy drive.

The system still works reliably after the oops btw.

LLaP
bero
