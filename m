Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTKLBzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 20:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTKLBzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 20:55:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:63406 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261298AbTKLBzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 20:55:20 -0500
Date: Tue, 11 Nov 2003 17:54:33 -0800
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, milang@tal.org,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Linux 2.4.23-rc1
Message-ID: <20031112015433.GA20145@kroah.com>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> <009001c3a89a$af611130$54dc10c3@amos> <002701c3a8a1$b1ce6380$54dc10c3@amos> <20031111145734.46d19c87.davem@redhat.com> <20031111231027.GC24159@parcelfarce.linux.theplanet.co.uk> <20031111150815.6a8aff01.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111150815.6a8aff01.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 03:08:15PM -0800, David S. Miller wrote:
> 
> It just so happens that the bits are layed out on Sparc such
> that we could only fit so many baud rate encodings, we didn't
> have enough left to define one for B4000000.
> 
> You will notice that in the entire 2.6.x tree, ir-usb.c is the
> only piece of code which makes reference to this value.

Then how is the ir-usb driver supposed to be able to set a baud rate of
4000000 in a portable manner?

thanks,

greg k-h
