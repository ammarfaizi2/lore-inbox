Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVDMIBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVDMIBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 04:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVDMIBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 04:01:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:50383 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262683AbVDMIBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 04:01:44 -0400
Date: Wed, 13 Apr 2005 00:12:34 -0700
From: Greg KH <greg@kroah.com>
To: Toralf Lund <toralf@procaptura.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: insmod segfault in pci_find_subsys()
Message-ID: <20050413071233.GB25581@kroah.com>
References: <423A9B65.1020103@procaptura.com> <20050318170709.GD14952@kroah.com> <42496309.3080007@procaptura.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42496309.3080007@procaptura.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 04:15:37PM +0200, Toralf Lund wrote:
> Greg KH wrote:
> 
> >On Fri, Mar 18, 2005 at 10:12:05AM +0100, Toralf Lund wrote:
> > 
> >
> >>Am I seeing an issue with the PCI functions here, or is it just that I 
> >>fail to spot an obvious mistake in the module itself?
> >>   
> >>
> >
> >I think it's a problem in your code.  I built and ran the following
> >example module just fine (based on your example, which wasn't the
> >smallest or cleanest...), with no oops.  Does this code work for you?
> > 
> >
> OK, I've finally been able to test this, and no, it does not work. 
> insmod segfaults and the system log says
> 
> kernel: Unable to handle kernel paging request at virtual address 533e3762

Then I think you have a broken build system or makefile or gcc.  It
works fine here.

thanks,

greg k-h
