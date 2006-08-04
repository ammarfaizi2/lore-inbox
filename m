Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161515AbWHDVrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161515AbWHDVrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161513AbWHDVrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:47:47 -0400
Received: from [198.99.130.12] ([198.99.130.12]:44449 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1161515AbWHDVrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:47:46 -0400
Date: Fri, 4 Aug 2006 17:46:43 -0400
From: Jeff Dike <jdike@addtoit.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Antonio Vargas <windenntw@gmail.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
Message-ID: <20060804214643.GA6407@ccure.user-mode-linux.org>
References: <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org> <1154667875.11382.37.camel@localhost.localdomain> <20060803225357.e9ab5de1.akpm@osdl.org> <1154675100.11382.47.camel@localhost.localdomain> <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz> <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com> <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz> <20060804194549.GA5897@ccure.user-mode-linux.org> <Pine.LNX.4.63.0608041246010.18862@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608041246010.18862@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 12:49:13PM -0700, David Lang wrote:
> >Why might you have to do that?
> 
> take this with a grain of salt, I'm not saying the particular versions I'm 
> listing would require this
> 
> if your new guest kernel wants to use some new feature (SKAS3, time 
> virtualization, etc) but the older host kernel didn't support some system 
> call nessasary to implement it, you may need to upgrade the host kernel to 
> one that provides the new features.

OK, yeah.

Just making sure you weren't thinking that the UML and host versions
were tied together (although a modern distro won't boot on a 2.6 UML
on a 2.4 host because UML's TLS needs TLS support on the host...).

				Jeff
