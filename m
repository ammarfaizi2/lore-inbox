Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263325AbUEPISP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUEPISP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 04:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUEPISP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 04:18:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27403 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263325AbUEPISN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 04:18:13 -0400
Date: Sun, 16 May 2004 09:18:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       "Hyok S. Choi" <hyok.choi@samsung.com>,
       linux-kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: MMUless CPU support?
Message-ID: <20040516091802.A3280@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Hyok S. Choi" <hyok.choi@samsung.com>,
	linux-kernel mailing-list <linux-kernel@vger.kernel.org>
References: <20040509152414.C17714@flint.arm.linux.org.uk> <409EC97D.7030105@samsung.com> <20040510094435.B27722@flint.arm.linux.org.uk> <409F62D5.6080500@samsung.com> <20040510123124.C27722@flint.arm.linux.org.uk> <409F7341.4090207@samsung.com> <042601c43905$beed50e0$0100a8c0@SHUTTLE> <20040513174521.A10776@flint.arm.linux.org.uk> <40A493CA.7030702@samsung.com> <20040516085858.A15133@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040516085858.A15133@infradead.org>; from hch@infradead.org on Sun, May 16, 2004 at 08:58:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 08:58:58AM +0100, Christoph Hellwig wrote:
> On Fri, May 14, 2004 at 06:39:22PM +0900, Hyok S. Choi wrote:
> > >And you can use assembler/linker magic to alias sys_fork to
> > >sys_ni_syscall.
> > >
> > >Since Hyok seems to be 100% against any kind of merge, it's useless
> > >even talking about this though.
> > >  
> > >
> > Hmm, I think about the clean and well structured kind of merge. His 
> > comment was useful for me. :-)
> > 
> > I always think almost all of tricky method to cross among codes is NO 
> > good, for maintainer, code readers, porting guys and all.
> > I like Vadim's method.
> 
> Where does this totally out of context post come from?  Given rmk is
> Cc'ed it's probably armnommu and you're probably still arguing that
> you don't want to merge the remaining tiny nommu bitws into arch/arm?
> 
> A bit more context would certainly help..

Hyok's mailer has done it _again_.  The CC list randomly changed from
linux-arm-kernel to lkml, so what you saw was a reply to one of my
messages on the linux-arm-kernel list, being copied out of context
to lkml.

This is at least the third time that I've known the CC list to randomly
change for no reason when Hyok has been replying, and this is the third
time I'm complaining about it.

Hyok - unless you stop this fscking annoying behaviour, you can expect
people to start ignoring you.  If its your mail client doing it, please
change your mail client to something more stable.  You're just _really_
pissing people off with what's currently happening with the CC: line
and that's not helping you one bit.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
