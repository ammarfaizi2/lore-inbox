Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264615AbTEPXNM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264619AbTEPXNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:13:11 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:33246 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264615AbTEPXNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:13:10 -0400
Date: Fri, 16 May 2003 16:21:09 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: jordan.breeding@sbcglobal.net, linux-kernel@vger.kernel.org,
       gibbs@scsiguy.com
Subject: Re: 2.5.69-mm5 errors in dmesg
Message-Id: <20030516162109.3547f928.akpm@digeo.com>
In-Reply-To: <20030516225443.GA16982@kroah.com>
References: <20030516054141.17385.qmail@web80105.mail.yahoo.com>
	<20030515231000.48497801.akpm@digeo.com>
	<20030516225443.GA16982@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2003 23:25:57.0822 (UTC) FILETIME=[811D9DE0:01C31C02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > > irq 16: nobody cared!
> > > ...
> > > handlers:
> > > [<f03c3162>] (usb_hcd_irq+0x0/0x58)
> > 
> > Well darn.  Surely usb_hcd_irq() is coded correctly.
> > 
> > Maybe there is something fishy going on in the USB state machinery.
> 
> I hope not :(
> 
> I don't seem to get those errors here, is the "handlers:" info a -mm
> only feature?

No, the "handlers" diagnostic is present in 2.5.69.

