Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUEORhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUEORhS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 13:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUEORhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 13:37:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:8167 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262459AbUEORhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 13:37:17 -0400
Date: Sat, 15 May 2004 10:37:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olh@suse.de>
cc: Greg KH <greg@kroah.com>, Erik Rigtorp <erkki@linux.nu>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB changes for 2.6.6
In-Reply-To: <20040515113251.GA27011@suse.de>
Message-ID: <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org>
References: <20040514224516.GA16814@kroah.com> <20040515113251.GA27011@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 May 2004, Olaf Hering wrote:
>  On Fri, May 14, Greg KH wrote:
> 
> >  drivers/usb/misc/cytherm.c           |    9 
> 
> current Linus tree does not compile:

Replace all "led" with "cytherm". The code was crap, and would never have
compiled with debugging on anyway. 

		Linus
