Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWIQSTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWIQSTt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 14:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWIQSTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 14:19:48 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:49838 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751205AbWIQSTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 14:19:48 -0400
Date: Sun, 17 Sep 2006 20:24:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Madhav Bhamidipati <madhavb@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on compiling a kernel Module
Message-ID: <20060917182459.GB1741@uranus.ravnborg.org>
References: <50b2ce660609150302s4f3de2afwf573b40f02a8d111@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50b2ce660609150302s4f3de2afwf573b40f02a8d111@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 03:32:06PM +0530, Madhav Bhamidipati wrote:
> Hello,
> 
> 
> I have the following source tree, objective is to get a single kernel
> module.ko object.
> 
> 
> module/
> module/sub-module1
> module/sub-module2
> module/include
> module/objs/
> 
> 
> module folder has a Makefile, it may or may not have *.c files, it
> invokes sub-* Makefiles
> which build respective objects, these objects need to go into objs
> folder, finally makefile in 'objs'
> builds the module.ko linking all sub-module *.o.
> 
> I could not find much information for my requirement in the file
> linux/Documentation/kbuild/makefiles.txt
Please read modules.txt in same dir.

Let me know if you miss info (patchewelcome!).

	Sam
