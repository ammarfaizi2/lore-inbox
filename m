Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932774AbWAHWDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbWAHWDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932776AbWAHWDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:03:08 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:40597 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932774AbWAHWDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:03:07 -0500
Date: Sun, 8 Jan 2006 15:03:07 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Carlos Manuel Duclos Vergara <carlos@embedded.cl>
Cc: kernel-janitors@lists.osdl.org, Kees Cook <kees@outflux.net>,
       linux-kernel@vger.kernel.org
Subject: Re: MODULE_VERSION useless? (was Re: [KJ] adding missing MODULE_* stuffs)
Message-ID: <20060108220307.GJ19769@parisc-linux.org>
References: <20051230000400.GS18040@outflux.net> <20060108204549.GB5864@mipter.zuzino.mipt.ru> <200601081855.17723.carlos@embedded.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601081855.17723.carlos@embedded.cl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 06:55:16PM -0300, Carlos Manuel Duclos Vergara wrote:
> I have two ideas about what to do with MODULE_VERSION:
> 1.- Defining MODULE_VERSION = KERNEL_VERSION
> 2.- Schedule it for removal in one or two more versions, and automagically use 
> the KERNEL_VERSION as module's version.
> 
> Any comments?

Do neither.  Just because some people don't use it properly is no reason
to remove it.

