Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbULPTEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbULPTEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbULPTB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:01:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:19132 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261980AbULPTAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:00:02 -0500
Date: Thu, 16 Dec 2004 10:59:50 -0800
From: Greg KH <greg@kroah.com>
To: bchimiak@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: More detail: Re: visor.ko freezes on dlpsh list
Message-ID: <20041216185950.GC5654@kroah.com>
References: <13677005.1103215413764.JavaMail.root@louie.psp.pas.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13677005.1103215413764.JavaMail.root@louie.psp.pas.earthlink.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 08:43:33AM -0800, bchimiak@earthlink.net wrote:
> It is the visor.[ch] of vmlinuz-2.6.9-1.681_FC3 that does not work.
> I recompiled a linux-2.6.9 kernel and the pilot-xfer, dlpsh, and kpilot work
> now.  It is the visor.[ch] in vmlinuz-2.6.9-1.681_FC3 that is the culprit.

Yes, that makes sense (see what Alan said.)  If you want to have fixes
for this driver, either use the 2.6.10-rc3 kernel, or the 2.6.9-ac tree.

thanks,

greg k-h
