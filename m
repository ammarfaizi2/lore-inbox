Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTEPWkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTEPWkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:40:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:18329 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262703AbTEPWkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:40:05 -0400
Date: Fri, 16 May 2003 15:54:43 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Jordan Breeding <jordan.breeding@sbcglobal.net>,
       linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: 2.5.69-mm5 errors in dmesg
Message-ID: <20030516225443.GA16982@kroah.com>
References: <20030516054141.17385.qmail@web80105.mail.yahoo.com> <20030515231000.48497801.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515231000.48497801.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 11:10:00PM -0700, Andrew Morton wrote:
> Jordan Breeding <jordan.breeding@sbcglobal.net> wrote:
> >
> > Hello,
> > 
> >   When booting 2.5.69-mm5 I have two errors showing up
> > in dmesg, the first is the usb irq handler message
> > below which is listed multiple times at boot:
> > 
> > irq 16: nobody cared!
> > ...
> > handlers:
> > [<f03c3162>] (usb_hcd_irq+0x0/0x58)
> 
> Well darn.  Surely usb_hcd_irq() is coded correctly.
> 
> Maybe there is something fishy going on in the USB state machinery.

I hope not :(

I don't seem to get those errors here, is the "handlers:" info a -mm
only feature?

thanks,

greg k-h
