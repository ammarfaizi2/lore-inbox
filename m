Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266024AbUAFACm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUAFAB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:01:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:57000 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266024AbUAFAAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:00:24 -0500
Date: Mon, 5 Jan 2004 14:39:51 -0800
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, milang@tal.org,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Linux 2.4.23-rc1
Message-ID: <20040105223950.GE30464@kroah.com>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> <009001c3a89a$af611130$54dc10c3@amos> <002701c3a8a1$b1ce6380$54dc10c3@amos> <20031111145734.46d19c87.davem@redhat.com> <20031111231027.GC24159@parcelfarce.linux.theplanet.co.uk> <20031111150815.6a8aff01.davem@redhat.com> <20031112015433.GA20145@kroah.com> <20031111223630.6f2bf759.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111223630.6f2bf759.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 10:36:30PM -0800, David S. Miller wrote:
> On Tue, 11 Nov 2003 17:54:33 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > Then how is the ir-usb driver supposed to be able to set a baud rate of
> > 4000000 in a portable manner?
> 
> You just won't get support for it on Sparc, nor any other
> platform that does not have the B4000000 macro defined.
> Ie.
> 
> #ifdef B4000000
> 		case B4000000:
> 			....
> #endif

I've finally made this change, and will send it onward in a few days.

thanks,

greg k-h
