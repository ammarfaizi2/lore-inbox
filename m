Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264403AbTEJPgY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbTEJPgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:36:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21648
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264403AbTEJPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:36:22 -0400
Subject: Re: [PATCH] Use correct x86 reboot vector
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: CaT <cat@zip.com.au>
Cc: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030510033504.GA1789@zip.com.au>
References: <20030510025634.GA31713@averell>
	 <20030510033504.GA1789@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052578182.16166.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 May 2003 15:49:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-10 at 04:35, CaT wrote:
> On Sat, May 10, 2003 at 04:56:34AM +0200, Andi Kleen wrote:
> > Extensive discussion by various experts on the discuss@x86-64.org
> > mailing list concluded that the correct vector to restart an 286+ 
> > CPU is f000:fff0, not ffff:0000. Both seem to work on current systems, 
> > but the first is correct.
> 
> Could this bug, by any chance, cause a system to shutdown instead of
> rebooting? This is what happens to me at the moment but not each and
> every time.

Unlikely. But try it and see 8)

At least some SMP boxes freak if you do a poweroff request on CPU != 0

