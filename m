Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVKGXgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVKGXgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965602AbVKGXgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:36:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40926 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965170AbVKGXgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:36:12 -0500
Date: Mon, 7 Nov 2005 15:34:58 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net,
       zaitcev@redhat.com
Subject: Re: 2.6.14-mm1: Why is USB_LIBUSUAL user-visible?
Message-Id: <20051107153458.034c6445.zaitcev@redhat.com>
In-Reply-To: <20051107211028.GU3847@stusta.de>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<20051107211028.GU3847@stusta.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005 22:10:28 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Nov 06, 2005 at 06:24:47PM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.14-rc5-mm1:
> >...
> > +gregkh-usb-usb-libusual.patch
> > 
> >  USB tree updates
> >...
> 
> IMHO, CONFIG_USB_LIBUSUAL shouldn't be a user-visible variable but 
> should be automatically enabled when it makes sense.

Sounds good, but too radical. Also, does not fix the issue at
hand, which is simply that I was confused in the triary logic
somewhere.

-- Pete
