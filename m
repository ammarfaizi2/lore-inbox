Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbWI0FDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbWI0FDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965262AbWI0FDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:03:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:44682 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965260AbWI0FDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:03:21 -0400
Date: Tue, 26 Sep 2006 21:54:36 -0700
From: Greg KH <greg@kroah.com>
To: Ryan Moszynski <ryan.m.lists@gmail.com>
Cc: linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.org>,
       David Kubicek <dave@awk.cz>
Subject: Re: /drivers/usb/class/cdc-acm.c patch question, please cc
Message-ID: <20060927045436.GB32644@kroah.com>
References: <fbf7c10b0609221445q1329eb5bsfe304c02f7f336db@mail.gmail.com> <200609241526.48659.oliver@neukum.org> <fbf7c10b0609241040j10bef8a0qce1d95d8cd98f981@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf7c10b0609241040j10bef8a0qce1d95d8cd98f981@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 01:40:19PM -0400, Ryan Moszynski wrote:
> 
> However, to get this(and i would guess any other evdo) card to work,
> you still have set up 4 config files:
> 
> ######
> etc/ppp/chap-secrets
> etc/ppp/peers/verizon
> etc/chatscripts/verizon-connect
> etc/chatscripts/verizon-disconnect
> #######
> 
> which makes it a lot more labor intensive to set up for the first time
> than it is in windows, but at least everything works.

Well, complain to the company that provides the cards.  On Windows there
is a pretty little application that handles all of this for you.
Luckily for me, that's all in userspace and the kernel doesn't care
about it :)

Glad it's now working for you,

greg k-h
