Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWGDVr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWGDVr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWGDVr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:47:57 -0400
Received: from ns2.suse.de ([195.135.220.15]:25043 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751256AbWGDVr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:47:56 -0400
Date: Tue, 4 Jul 2006 14:44:09 -0700
From: Greg KH <gregkh@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL][PATCH] include/linux/Kbuild devfs fix
Message-ID: <20060704214409.GA23221@suse.de>
References: <44AACE30.3000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AACE30.3000601@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 10:23:12PM +0200, Michal Piotrowski wrote:
> Hi,
> 
> I get this error while "make O=/dir headers_install"
> 
> sed: can't read /usr/src/linux-git/include/linux/devfs_fs.h: No such file or directory
> make[3]: *** [devfs_fs.h] Error 2
> make[2]: *** [linux] Error 2
> make[1]: *** [headers_install] Error 2
> make: *** [headers_install] Error 2
> 
> Here is a patch

Linus already caught this :)

thanks,

greg k-h
