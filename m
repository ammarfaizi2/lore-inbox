Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269353AbUJFSYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269353AbUJFSYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUJFSYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:24:38 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:33997 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269357AbUJFSU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:20:56 -0400
Message-Id: <200410061821.i96IL9a07610@raceme.attbi.com>
Subject: Re: Solaris developer wants a Linux Mentor for drivers. 
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Oct 2004 13:21:09 -0500 (CDT)
From: kilian@bobodyne.com (Alan Kilian)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarded message:
> From: Greg KH <greg@kroah.com>
> 
> Why not 2.6?  No new Linux distros are shipping 2.4 kernels anymore...

  Well, I down loaded and installed RedHat-9 5 weeks ago, and it
  is a 2.4 kernel, so I thought that would be fine.
  (See what a novice I am?)

> And a PCI bus driver?  
> What kind of hardware is this?  
> Is this a driver for a pci card, or a pci bus controller?

  This is a driver for talking to my hardware which is a PCI bus card.

  This card has 5 large FPGAs, SRAM and dram on it which is used to
  accelerate bioinformatics search algorithms.

  The card works under Sun Solaris and Windows/2000, and of course,
  we would like to add Linux to the list.

  Eventually, I'll need to support DMA to and from the card, but
  I can get by for a while just doing single-dword I/O.

  

  I just hacked in dev->bus->ops->read_dword(dev,1,&retval);
  and I can read memory on the card! (Well, things don't crash anyway)

  If this is absolutely the wrong way to do this, please let me know!

  Note: I have no idea what the second parameter to read_dword() is!

                            -Alan

-- 
- Alan Kilian <kilian(at)timelogic.com> 
Director of Bioinformatics, TimeLogic Corporation 763-449-7622
