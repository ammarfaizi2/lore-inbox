Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTHZPE4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbTHZPEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:04:55 -0400
Received: from moth.netsolus.com ([65.16.30.101]:1152 "EHLO moth")
	by vger.kernel.org with ESMTP id S262947AbTHZPEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:04:51 -0400
Subject: Re: Interesting problem with 450NX based Compaq server
From: Bryan Ballard <ballard@netsolus.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030825225820.2d1c6e29.akpm@osdl.org>
References: <1061875433.24196.15.camel@ant>
	 <20030825225820.2d1c6e29.akpm@osdl.org>
Message-Id: <1061910289.31208.10.camel@ant>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Aug 2003 10:04:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running the latest 2.4.22 and still having the problem. Do you have
any pointers for options that may need to be turned off in the kernel
configuration?
I will try and get a new motherboard and see if that is the problem. 

On Tue, 2003-08-26 at 00:58, Andrew Morton wrote:
> Bryan Ballard <ballard@netsolus.com> wrote:
> >
> > Hello, I've looked through the kernel list archives and haven't found
> >  anything that might help. I have a Compaq 5500r 4x500mhz Xeons and
> >  whenever a heavy load is placed on the box it reboots without any kernel
> >  panics or oops. It seems to be related primarily to multiple PCI card
> >  access, i.e. during heavy RAID card / NIC interaction. I've tried to
> >  isolate it by replacing NICs and RAID cards, but the only thing I can
> >  come up with is that it is related to the 450NX chipset. 
> >  Since I am not sure anyone is still working on the 450NX chipset I've
> >  refrained from cluttering the list with a giant E-mail full of /proc
> >  data until someone answers back that they would be interested in any
> >  information that I can provide them.
> 
> I have an Intel ad450nx server, based on the 450NX PCISet chipset. 
> 4x500MHz Xeons.  It runs like a champ.
> 
> Maybe you have a buggy kernel.  Try a vendor patch, or switch vendors,
> or try a kernel.org kernel or something like that?
-- 
Bryan Ballard
Netsolus Consultants
http://www.netsolus.com


