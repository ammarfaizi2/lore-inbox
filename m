Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268471AbUHLAwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268471AbUHLAwY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268513AbUHLAsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:48:36 -0400
Received: from web14925.mail.yahoo.com ([216.136.225.11]:13660 "HELO
	web14925.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268521AbUHLApb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:45:31 -0400
Message-ID: <20040812004525.26380.qmail@web14925.mail.yahoo.com>
Date: Wed, 11 Aug 2004 17:45:25 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040811172800.GB14979@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to add a pointer to struct pci_dev to track the attribute copy
with the size in it. Would you rather have me add the pointer or or
change the sysfs rules to state that a copy of the length is made?

--- Greg KH <greg@kroah.com> wrote:
> > Greg was a little worried that your comment
> > 	/* .size is set individually for each device, sysfs copies it into
> dentry */
> > might not be correct.
> 
> I looked at the code, and he's right.  But it's pretty scary that it
> works correctly so I'd prefer to do it the way your patch did it
> (create
> a new attribute for every entry.)
> 
> thnaks,
> 
> greg k-h
> 


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
