Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUDLSzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 14:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUDLSzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 14:55:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:20143 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263024AbUDLSzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 14:55:49 -0400
Date: Mon, 12 Apr 2004 11:49:12 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: brking@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
Message-ID: <20040412184912.GB21502@kroah.com>
References: <4072F2B7.2070605@us.ibm.com> <20040406172903.186dd5f1.akpm@osdl.org> <20040407061146.GA10413@kroah.com> <407487A6.8020904@us.ibm.com> <20040408224713.GD15125@kroah.com> <40770AD0.4000402@us.ibm.com> <20040409205344.GA5236@kroah.com> <20040409141511.4e372554.akpm@osdl.org> <20040410165322.GG1317@kroah.com> <20040410131137.0eff0ae2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410131137.0eff0ae2.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 01:11:37PM -0700, Andrew Morton wrote:
> 
> void *kzmalloc(size_t size, int gfp_flags);
> 
> 	kmalloc() then bzero().

Sure, make the kernel-janitor's list even longer now :)

> char *kstrdup(char *p, int gfp_flags);
> 
> 	kmalloc() then strcpy()

Haha, that's Rusty's "Is Linus Awake" patch he tries to send every 6
months or so...

greg k-h
