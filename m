Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVDVAvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVDVAvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVDVAvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:51:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:39914 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261841AbVDVAvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:51:40 -0400
Date: Thu, 21 Apr 2005 17:31:20 -0700
From: Greg KH <greg@kroah.com>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050422003120.GC6829@kroah.com>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <4267ABB6.2080208@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4267ABB6.2080208@domdv.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 03:33:42PM +0200, Andreas Steinmetz wrote:
> Compile error on x86_64:
> 
>   CC [M]  drivers/usb/image/microtek.o
> drivers/usb/image/microtek.c: In function `mts_scsi_abort':
> drivers/usb/image/microtek.c:338: error: `FAILURE' undeclared (first use
> in this function)

Patch to fix this was posted on lkml and is in my queue to send to Linus
in a bit.

thanks,

greg k-h
