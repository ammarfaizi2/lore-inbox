Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVCGXEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVCGXEi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVCGXBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:01:38 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38078 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261771AbVCGVRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:17:13 -0500
Subject: Re: 2.6.11-mm1 (x86-abstract-discontigmem-setup.patch)
From: Dave Hansen <haveblue@us.ibm.com>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200503060121.19354.adobriyan@mail.ru>
References: <200503051535.24372.adobriyan@mail.ru>
	 <1110049138.6446.3.camel@localhost>  <200503060121.19354.adobriyan@mail.ru>
Content-Type: text/plain
Date: Mon, 07 Mar 2005 13:16:50 -0800
Message-Id: <1110230210.6446.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-06 at 01:21 +0200, Alexey Dobriyan wrote:
> On Saturday 05 March 2005 20:58, Dave Hansen wrote:
> > On Sat, 2005-03-05 at 15:35 +0200, Alexey Dobriyan wrote:
> > > > +	}
> > > > +	printk(KERN_DEBUG "\n");
> > > 	       ^^^^^^^^^^
> > > > +}
> > > 
> > > Too much KERN_DEBUG.
> > 
> > On my system, that ends up printing out 4 or 5 lines of output per node,
> > but it's quite invaluable if you're debugging early memory setup issues.
> > It is KERN_DEBUG after all.  What does it do on your system?
> > 
> > I'm not horribly opposed to removing some of this output, let's just
> > make sure...
> 
> You misundestood. I'm not proposing to remove these printk's altogether. I'm
> for removing KERN_DEBUG solely in the middle of the line.
> 
> Try the following program with and without 3-rd and 4-th KERN_DEBUG.

Yep, I misunderstood :)



-- Dave

