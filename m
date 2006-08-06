Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWHFBED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWHFBED (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 21:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWHFBEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 21:04:01 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13697 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932681AbWHFBEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 21:04:01 -0400
Subject: Re: ACLs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: RazorBlu <razorblu@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44D4EB88.6050406@gmail.com>
References: <44D3BF62.10202@gmail.com> <1154729992.3573.35.camel@brianb>
	 <44D3CFB9.9020208@gmail.com> <F493D385-0915-442A-853A-00B3ED75B8B2@mac.com>
	 <44D3DE48.8060103@gmail.com> <20060805014722.GA19509@mail>
	 <44D4EB88.6050406@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 06 Aug 2006 02:23:38 +0100
Message-Id: <1154827418.10971.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-08-05 am 21:03 +0200, ysgrifennodd RazorBlu:
> That is part of my point. The ACL system included with Linux (whether it 
> be the POSIX ACLs or SELinux) are too complex for use by most system 
> administrators, and so are overlooked. Actually, that last statement is 
> untrue - POSIX ACLs seem to be lacking slightly in functionality, and 
> SELinux is overly complicated (see a previous reply in which someone 
> else said that). AppArmor seems to be heading along the right tracks, 

It depends what you are trying to achieve. 

> policy for a service. However, it probably won't be included in the 
> kernel, especially in the near future (SELinux, which is associated with 
> the NSA, is already there - why add another one, even if it is more 
> advanced?)

I think the consensus if anything was more to adding AppArmor once it is
cleaned up than not. Its far more primitive than SELinux and has a very
basic security model but it can be easier to configure some basic setups
with it which makes it useful to some people

The LSM means the kernel doesn't have to have an opinion any more than
it has to define your choice of file system.

> Because SELinux is too complicated to be used effectively by most system 
> administrators - that's why.

Thats why vendors ship policies. Firewalling has the same problem.

Alan

