Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWBSKhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWBSKhd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 05:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWBSKhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 05:37:33 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:19872 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932390AbWBSKhb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 05:37:31 -0500
To: Dave Jones <davej@redhat.com>
From: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: dvb breakage
In-reply-to: <20060219020847.GA5412@redhat.com>
Message-Id: <E1FAlwT-0007O3-00@decibel.fi.muni.cz>
Date: Sun, 19 Feb 2006 11:37:25 +0100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@informatics.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>On Thu, Jan 12, 2006 at 12:08:43AM -0800, Linux Kernel wrote:
> > tree 735e941317b10973cd06bf63bdcf1140d2ef7412
> > parent d4437d3fada351d7f40bcc48a62c12b92e2ad9d8
> > author Jiri Slaby <xslaby@fi.muni.cz> Wed, 11 Jan 2006 23:41:13 -0200
> > committer Mauro Carvalho Chehab <mchehab@brturbo.com.br> Wed, 11 Jan 2006 23:41:13 -0200
> > 
> > V4L/DVB (3344c): Pci probing for stradis driver
> > 
> > - Pci probing functions added, some functions were rewritten.
> > 
> > - Use PCI_DEVICE macro.
> > 
> > - dev_ used for printing when pci_dev available.
> > 
> > Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
>
>Jiri,
> I'm not sure if this the exact cset that broke it, but 
>one of our users reports that since around this time,
>udev stopped creating a /dev/dvb/adaptor0
>
>Did this inadvertantly change how things look in sysfs?
>
>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
Went through changes once more time, but with any result, I have really no
idea. Will see, what he'll reply.

thanks,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
