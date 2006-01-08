Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWAHV6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWAHV6w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWAHV6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:58:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:50577 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932394AbWAHV6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:58:51 -0500
Date: Sun, 8 Jan 2006 13:58:00 -0800
From: Greg KH <greg@kroah.com>
To: Carlos Manuel Duclos Vergara <carlos@embedded.cl>
Cc: kernel-janitors@lists.osdl.org, Kees Cook <kees@outflux.net>,
       linux-kernel@vger.kernel.org
Subject: Re: MODULE_VERSION useless? (was Re: [KJ] adding missing MODULE_* stuffs)
Message-ID: <20060108215800.GA31398@kroah.com>
References: <20051230000400.GS18040@outflux.net> <20060108204549.GB5864@mipter.zuzino.mipt.ru> <200601081855.17723.carlos@embedded.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601081855.17723.carlos@embedded.cl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 06:55:16PM -0300, Carlos Manuel Duclos Vergara wrote:
> Hi everyone,
> 
> I have two ideas about what to do with MODULE_VERSION:
> 1.- Defining MODULE_VERSION = KERNEL_VERSION

No.

> 2.- Schedule it for removal in one or two more versions, and automagically use 
> the KERNEL_VERSION as module's version.

No, just let the authors of the different drivers that want to use
MODULE_VERSION use it (for some people it does matter, and they keep it
up to date.)  Everyone else, just don't add it if you don't care about
it.

> Any comments?

In short, leave it alone :)

thanks,

greg k-h
