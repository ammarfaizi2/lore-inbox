Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbUBBHey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 02:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbUBBHey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 02:34:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:49308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265651AbUBBHex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 02:34:53 -0500
Date: Sun, 1 Feb 2004 23:34:51 -0800
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools/udev and module auto-loading
Message-ID: <20040202073451.GA23181@kroah.com>
References: <E1AnYNT-0002Tp-00.arvidjaar-mail-ru@f17.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AnYNT-0002Tp-00.arvidjaar-mail-ru@f17.mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 10:20:15AM +0300, "Andrey Borzenkov"  wrote:
> 
> so there are cases when "action on access" makes sense.

Yes, there are cases like this where that might make sense.  However
there's no real way for udev itself to solve those cases.  You will have
to rely on some other method to do this (script to load module, making
the /dev node yourself, script to make dev node and then access it which
causes kmod to load the module, etc.)

thanks,

greg k-h
