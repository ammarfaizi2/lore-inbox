Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUD1XX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUD1XX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUD1XX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:23:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29140 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261791AbUD1XX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:23:56 -0400
Date: Wed, 28 Apr 2004 20:25:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Norman Zhang <norman.zhang@rd.arkonnetworks.com>
Cc: linux-kernel@vger.kernel.org,
       Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Kernel 2.4.26 Hangs During Boot
Message-ID: <20040428232501.GD16387@logos.cnet>
References: <32789.206.116.24.97.1082645283.squirrel@mail.rd.arkonnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32789.206.116.24.97.1082645283.squirrel@mail.rd.arkonnetworks.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 07:48:03AM -0700, Norman Zhang wrote:
> Hi,
> 
> I compiled kernel-2.4.26 with
> 
> # make xconfig
> # make dep
> # make bzImage
> # make modules
> # make modules_install
> # make install
> 
> But when I booted the new kernel, I get a complete freeze with no errors
> or warnings. However IDE disk does spins for awhile. When I rebooted my
> old kernel, it complains disk corruption. I'm not sure if it is IDE bug.
> Would someone please give me a few pointers here? I've attached lspci,
> dmesg, and config below.

It seems you are using swsusp2? Can you confirm the problem exists in mainline?

That will help tracking down the bug.
