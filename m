Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUDHVv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUDHVv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:51:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:45013 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262049AbUDHVvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:51:24 -0400
Date: Thu, 8 Apr 2004 14:44:12 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>, geert@sonycom.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       noring@nocrew.org, lars@nocrew.org, tomas@nocrew.org
Subject: Re: [PATCH 2.6] add class support to dsp56k.c
Message-ID: <20040408214412.GA14183@kroah.com>
References: <61760000.1081379610@dyn318071bld.beaverton.ibm.com> <Pine.GSO.4.58.0404080952171.9729@waterleaf.sonytel.be> <74830000.1081443573@dyn318071bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74830000.1081443573@dyn318071bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 09:59:33AM -0700, Hanna Linder wrote:
> --On Thursday, April 08, 2004 10:12:19 AM +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > On Wed, 7 Apr 2004, Hanna Linder wrote:
> >> Here is a patch that adds sysfs class support to /drivers/char/dsp56k.c
> >> 
> >> I dont have the hardware or a cross compiler... If someone could test it
> >> I would appreciate it.
> > 
> > Cross-compiles fine here, but further untested due to lack of hardware.
> 
> Thanks!
> 
> >> +out_chrdev:
> >> +	unregister_chrdev(DSP56K_MAJOR, "sdp56k");
> >> +out:
> 
> I just noticed this error. Here is the fixed patch:

Thanks, I've applied this version.

greg k-h
