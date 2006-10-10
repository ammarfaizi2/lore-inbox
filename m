Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWJJOI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWJJOI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWJJOI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:08:56 -0400
Received: from mail6.postech.ac.kr ([141.223.1.112]:4741 "EHLO
	mail6.postech.ac.kr") by vger.kernel.org with ESMTP id S932093AbWJJOIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:08:55 -0400
Date: Tue, 10 Oct 2006 23:09:33 +0900
From: Seongsu Lee <senux@senux.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: specifying the order of calling kernel functions (or modules)
Message-ID: <20061010140933.GA16075@pooky.senux.com>
References: <20060928101724.GA18635@pooky.senux.com> <200609281547.k8SFl3Au004978@turing-police.cc.vt.edu> <20060930104205.GB10248@pooky.senux.com> <20060930094731.2fe41e12.rdunlap@xenotime.net> <20061007144139.GA2155@pooky.senux.com> <20061007082752.6ff90517.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007082752.6ff90517.rdunlap@xenotime.net>
X-TERRACE-SPAMMARK: NO       (SR:8.89)                     
  (by Terrace)                                                   
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 08:27:52AM -0700, Randy Dunlap wrote:
> On Sat, 7 Oct 2006 23:41:39 +0900 Seongsu Lee wrote:
> 
> > Hello,
> > 
> > Thank you for the replys.
> > 
> > I try to phrase differently.
> > 
> > I made a simple kernel module that do 'hello world'. The module will be
> > called when I do 'modprobe' or 'insmod' to load it into the memory.
> > 
> > When is the function, init_module(), in the module called in the case 
> > the module is compiled as a built-in one? (Not M but Y in .config)
> > Can I specify the exact time of calling the function, init_module() in
> > the module?
> 
> That depends on the order that it is listed in the (nested)
> Makefiles.  Which sub-directory and Makefile will you use?

drivers/mtd/Makefile

Yes, I confirmed that the order of being called is same with
the order that is listed in the Makefiles.

I think it is better to post questions of kernel newbie like this
into other mailing lists instead of this, developer list. 

Anyway, thank you very much for your help.

-- 
Seongsu Lee - http://www.senux.com/
Your job is being a professor and researcher: That's
one hell of a good excuse for some of the
brain-damages of minix. (Linus Torvalds to Andrew
Tanenbaum)




