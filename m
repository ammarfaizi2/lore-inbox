Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVAMRfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVAMRfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVAMRfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:35:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:44004 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261328AbVAMReF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:34:05 -0500
Subject: Re: RAIT device driver feasibility
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ludovic Drolez <ludovic.drolez@linbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E6AB59.4000808@linbox.com>
References: <41E696F4.3070700@linbox.com>
	 <1105630888.4664.54.camel@localhost.localdomain>
	 <41E6AB59.4000808@linbox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105633782.4664.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 16:29:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 17:09, Ludovic Drolez wrote:
> > Why kernel space - why not a user space shared library you can add to
> > other tape apps?
> 
> A shared library which would override read(), write() in the program ? Why not...
> 
> But do you think you can chain/bounce, ioctl(), read(), writes from a char 
> driver to another ?

I was thinking more of an easy to use shared library and adapting the
various tape archiving apps to be able to use it, not emulation

