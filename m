Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWBMJZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWBMJZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWBMJZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:25:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:27280 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751675AbWBMJZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:25:50 -0500
From: Andi Kleen <ak@suse.de>
To: Roberto Nibali <ratz@drugphish.ch>
Subject: Re: [discuss] trap int3 problem while porting a user space application and small cleanup patch
Date: Mon, 13 Feb 2006 10:25:43 +0100
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <43EF6B7D.5080607@drugphish.ch> <200602130157.36084.ak@suse.de> <43F03B7F.2030701@drugphish.ch>
In-Reply-To: <43F03B7F.2030701@drugphish.ch>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602131025.43826.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 08:55, Roberto Nibali wrote:
> Hello Andi,
> 
> Thanks for your comments.
> 
> >> The issue I'm trying to track down now is why I cannot get it to work on 
> >> a x86_64 kernel (Sun Fire V20z with AMD Opteron(tm) Processor 252 on 
> >> SLES 9 PL3). I suspect 32/64 bit issues between in my ioctl message 
> >> passing between user space and kernel space.
> > 
> > Quite possible. The mpt ioctls would need a ioctl conversion handler
> > to allow a 32bit program to use the 64bit ioctls. Or just use a 64bit
> > executable.
> 
> It is a 64bit executable:

Then whatever problem the program has is not enabled to 32bit ioctl emulation.
Maybe it has some generic 64bit issues.

Thanks for looking into it.

-Andi
