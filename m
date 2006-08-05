Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbWHELbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWHELbz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 07:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161188AbWHELby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 07:31:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41453 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161108AbWHELby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 07:31:54 -0400
Subject: Re: A proposal - binary
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       pazke@donpac.ru, Andi Kleen <ak@suse.de>
In-Reply-To: <44D42E7D.70101@vmware.com>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <20060804183448.GE11244@sequoia.sous-sol.org> <44D3B0F0.2010409@vmware.com>
	 <1154726800.23655.273.camel@localhost.localdomain>
	 <1154740485.3683.161.camel@mulgrave.il.steeleye.com>
	 <44D42E7D.70101@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 05 Aug 2006 12:50:18 +0100
Message-Id: <1154778619.10971.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-04 am 22:37 -0700, ysgrifennodd Zachary Amsden:
> mentioned earlier.  Is it a license violation for a GPL app to link 
> against a non-GPL library?  Surely, the other way around is a problem, 


Actually the FSF always anticipated that case because its the same as
the GPL app on non-free OS case and the GPL there says

"However, as a special exception, the source code distributed need not
include anything that is normally distributed (in either source or
binary form) with the major components (compiler, kernel, and so on) of
the operating system on which the executable runs, unless that component
itself accompanies the executable."

> interface, which gives it shape.  So I prefer binary redirection 
> interface, or vDSO, or anything without the disparaged word "blob" in it.

Well if you are going to provide the source then its not really a binary
interface, its a jump table.
