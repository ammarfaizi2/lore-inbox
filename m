Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264121AbTDJRjJ (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbTDJRjJ (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:39:09 -0400
Received: from crack.them.org ([65.125.64.184]:57736 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S264121AbTDJRjI (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 13:39:08 -0400
Date: Thu, 10 Apr 2003 13:50:33 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Dan Kegel <dank@kegel.com>
Cc: wd@denx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: gcc-2.95 broken on PPC?
Message-ID: <20030410175033.GA14969@nevyn.them.org>
Mail-Followup-To: Dan Kegel <dank@kegel.com>, wd@denx.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E95AF4F.20105@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E95AF4F.20105@kegel.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 10:52:15AM -0700, Dan Kegel wrote:
> The Denkster wrote:
> >>However, bugs #1 (zlib.c) and #3 (div64.h) disappear if I compile
> >>my kernels with gcc-3.2.2 instead of 2.95.4, which is a strong
> >>indication that 2.95.4 is broken on PPC. Is this something that's
> >
> >This is speculation only. We use gcc-2.95.4 as part of  our  ELDK  in
> >all  of our projects, and a lot of people are using these tools, too.
> >We definitely see more problems with gcc-3.x compilers.
> 
> Hi Wolfgang, when you say you see more problems with gcc-3.x
> compilers, what is x?  I'd understand if you saw problems
> with gcc-3.0.*, but I had hoped that gcc-3.2.2 would compile
> good kernels for ppc.
> (Me, I'm still using Montavista Linux 2.0's gcc-2.95.3 to build my ppc 
> kernels,
> but am looking for an excuse to switch to gcc-3.2.* or gcc-3.3.*.)
> - Dan

Both 3.2 and 3.3 are working well for us here.  3.2's received much
better testing.  I think we tripped up about four bugs in 3.2.2 that
needed patches, but that's well below par compared to 2.95.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
