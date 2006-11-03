Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWKCVwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWKCVwJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWKCVwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:52:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932168AbWKCVwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:52:07 -0500
Date: Fri, 3 Nov 2006 13:51:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrew.j.wade@gmail.com
Cc: linux-kernel@vger.kernel.org,
       Charlotte Richardson <charlotte.richardson@stratus.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.19-rc4-mm2
Message-Id: <20061103135151.60762144.akpm@osdl.org>
In-Reply-To: <200611031642.36558.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <20061101235407.a92f94a5.akpm@osdl.org>
	<200611031642.36558.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006 16:42:33 -0500
Andrew James Wade <andrew.j.wade@gmail.com> wrote:

> On Thursday 02 November 2006 02:54, Andrew Morton wrote:
> > - Lots of fbdev updates.  We haven't heard from Tony in several months, so I
> >   went on a linux-fbdev-devel fishing expedition.
> 
> radeonfb-support-24bpp-32bpp-minus-alpha.patch broke my video: my
> screen ended up garbled. (vc1 was ok, strangely enough). Reverting
> fixed things. 
> 
> lspci -v:
> 
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500] (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc Radeon 7500
>         Flags: bus master, stepping, 66MHz, medium devsel, latency 64, IRQ 16
>         Memory at d8000000 (32-bit, prefetchable) [size=128M]
>         I/O ports at d800 [size=256]
>         Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
>         Expansion ROM at d7fe0000 [disabled] [size=128K]
>         Capabilities: <available only to root>
> 

Great, thanks for working that out.  I'll drop the patch.
