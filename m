Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUHHCxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUHHCxM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 22:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUHHCxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 22:53:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:51879 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265041AbUHHCxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 22:53:10 -0400
Date: Sat, 7 Aug 2004 19:52:29 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, arjanv@redhat.com, dwmw2@infradead.org,
       jmorris@redhat.com, chrisw@osdl.org, sfrench@samba.org, mike@halcrow.us,
       trond.myklebust@fys.uio.no, mrmacman_g4@mac.com
Subject: Re: [PATCH] implement in-kernel keys & keyring management
Message-ID: <20040808025229.GA15737@kroah.com>
References: <6453.1091838705@redhat.com> <20040807011758.62831dbf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807011758.62831dbf.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 01:17:58AM -0700, Andrew Morton wrote:
> - Various people are likely to get upset about this:
> 
>   asmlinkage long sys_keyctl(int option, unsigned long arg2, unsigned long arg3,
> 		   unsigned long arg4, unsigned long arg5)
> 
>   I guess the pure way to do it is to add 13 new syscalls....

I think that if the /proc interface was moved over to sysfs (which is
where it should be), a number of these syscalls would go away.

thanks,

greg k-h
