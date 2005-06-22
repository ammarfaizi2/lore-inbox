Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVFVXZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVFVXZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 19:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVFVXXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 19:23:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41962 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261486AbVFVXXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 19:23:13 -0400
Date: Wed, 22 Jun 2005 16:25:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <20050622230905.GA7873@kroah.com>
Message-ID: <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Greg KH wrote:
> 
> Ok, this is annoying.  Is there some reason why git doesn't pull the
> tags in properly when doing a merge?  Chris and I just hit this when I
> pulled his 2.6.12.1 tree and and was wondering where the tag went.

Tags are private in git (the same way branches are), which means that you
can have a million of your own tags and never disturb anybody else.

But, like branches, it means that if you want a tag, you need to know the 
tag you want, and download it the same way you download a branch.

		Linus
