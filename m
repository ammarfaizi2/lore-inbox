Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSFGT7X>; Fri, 7 Jun 2002 15:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317335AbSFGT7W>; Fri, 7 Jun 2002 15:59:22 -0400
Received: from host.greatconnect.com ([209.239.40.135]:52746 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S317334AbSFGT7W>; Fri, 7 Jun 2002 15:59:22 -0400
Subject: Re: PDC20267 + RAID can't find raid device
From: Samuel Flory <sflory@rackable.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Thompson <wt@electro-mechanical.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1023463727.25522.39.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Jun 2002 12:54:06 -0700
Message-Id: <1023479646.3700.174.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-07 at 08:28, Alan Cox wrote:
> On Thu, 2002-06-06 at 20:18, Samuel Flory wrote:
> >   One major issue for me is that you can use, and mount both the
> > /dev/ataraid/d0 devices, and the /dev/hd devices.  This makes for lots
> > of fun in the Red Hat installer, and Cerberus.   
> 
> Stupidity management for the superuser is a user space issue in Unix
> systems. If the RH installer does let you do stupid things, please
> bugzilla it.

  Actually I was looking at what it would take to add support for
ataraid in the RH installer.  Is there some simple way to determine that
a device is a part of an ataraid array?  Parsing dmesg makes for some
really ugly and easily broken code.


