Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWGaT0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWGaT0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWGaT0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:26:14 -0400
Received: from terminus.zytor.com ([192.83.249.54]:56746 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030350AbWGaT0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:26:13 -0400
Message-ID: <44CE5940.5090700@zytor.com>
Date: Mon, 31 Jul 2006 12:25:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       stable@kernel.org, akpm@osdl.org, chrisw@sous-sol.org, grim@undead.cc
Subject: Re: [stable] [PATCH] initramfs: Allow rootfs to use tmpfs instead
 of ramfs
References: <200607301808.14299.a1426z@gawab.com> <20060730175109.GA20777@kroah.com> <200607310003.56832.a1426z@gawab.com>
In-Reply-To: <200607310003.56832.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> 
> Well, ramfs has some pitfalls, which doesn't make it suitable for a 
> long-lived rootfs.  OTOH, tmpfs is much more mature, while semantically the 
> same.
> 
> Being semantically the same, while not exhibiting ramfs pitfalls, makes it 
> suitable to be pushed into the -stable tree, IMHO.
> 

This is total nonsense.  They're very different from an implementation 
standpoint.

	-hpa
