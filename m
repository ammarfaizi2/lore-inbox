Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUAYXaO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUAYXaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:30:13 -0500
Received: from nevyn.them.org ([66.93.172.17]:56251 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265359AbUAYXaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:30:03 -0500
Date: Sun, 25 Jan 2004 18:30:00 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Userland headers available
Message-ID: <20040125233000.GA3319@nevyn.them.org>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <200401231907.17802.mmazur@kernel.pl> <20040123184755.GA2138@nevyn.them.org> <401172D8.8040507@nortelnetworks.com> <4011788D.3070606@nortelnetworks.com> <busi9u$fd7$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <busi9u$fd7$1@terminus.zytor.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 01:38:06AM +0000, H. Peter Anvin wrote:
> Followup to:  <4011788D.3070606@nortelnetworks.com>
> By author:    Chris Friesen <cfriesen@nortelnetworks.com>
> In newsgroup: linux.dev.kernel
> >
> > Friesen, Christopher [CAR:7Q28:EXCH] wrote:
> > 
> > > The obvious way is to have the kernel headers include the userland
> > > headers, then everything below that be wrapped in "#ifdef __KERNEL__". 
> > > Userland then includes the normal kernel headers, but only gets the 
> > > userland-safe ones.
> > 
> > I just realized this wasn't clear.  I envision a new set of headers in 
> > the kernel that are clean to export to userland.  The current headers 
> > then include the appropriate userland-clean ones, and everything below 
> > that is kernel only.
> > 
> > This lets the kernel maintain the userland-clean headers explicitly, and 
> > we don't have the work of cleaning them up for glibc.
> > 
> 
> We've referred to this for quite a while as the "ABI header project";
> it's been targetted for 2.7, since it missed the 2.6 freeze.
> 
> We have set up a mailing list at:
> 
> 	http://zytor.com/mailman/listinfo/linuxabi
> 
> The goal is to get a formal exportable version of the kernel ABI that
> user-space libraries can use.

Are the list archives broken, or has there never been traffic on this
list?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
