Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132564AbRDOBgQ>; Sat, 14 Apr 2001 21:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132565AbRDOBgG>; Sat, 14 Apr 2001 21:36:06 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:50550 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132564AbRDOBfx>; Sat, 14 Apr 2001 21:35:53 -0400
Date: Sat, 14 Apr 2001 21:35:46 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: nicholas@petreley.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-uhci.c problems in latest kernels?
Message-ID: <20010414213546.A1590@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> usb-uhci.c: interrupt, status 3, frame# 1876 

This is a known problem, here is the discussion that I initiated
on linux-usb-devel:

 http://marc.theaimsgroup.com/?t=98609508500001&w=2&r=1

The right fix is to comment that printout out.
In fact, that is what I commited for Red Hat 7.1 release.

Some people suggest to switch to uhci instead of usb-uhci,
which helps precisely because it does not have a corresponding
printk.

-- Pete
