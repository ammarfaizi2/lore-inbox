Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVGLDJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVGLDJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVGLDJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:09:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:16552 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261972AbVGLDIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:08:02 -0400
Date: Mon, 11 Jul 2005 20:07:43 -0700
From: Greg KH <greg@kroah.com>
To: Marc Aurele La France <tsi@ualberta.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel header policy
Message-ID: <20050712030742.GB1487@kroah.com>
References: <Pine.BSO.4.61.0507111533340.23021@login3.srv.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.61.0507111533340.23021@login3.srv.ualberta.ca>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 03:37:47PM -0600, Marc Aurele La France wrote:
> I am contacting you to express my concern over a growing trend in kernel
> development.  I am specifically referring to changes being made to kernel
> headers that break compatibility at the userland level, where __KERNEL__
> isn't #define'd.

Kernel headers are not to be included by userspace programs.  See the
archives for details...

> b) <linux/pci.h> has been broken since 2.5.62's development cycle and has
>    yet to be fixed.  Here, the #include of <linux/mod_devicetable.h> needs
>    to be bracked by __KERNEL__.  This is another occurrence of "1)".

-ENOPATCH.

thanks,

greg k-h
