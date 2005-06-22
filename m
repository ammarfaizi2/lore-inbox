Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVFVA1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVFVA1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVFVAXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:23:18 -0400
Received: from smtpauth06.mail.atl.earthlink.net ([209.86.89.66]:49129 "EHLO
	smtpauth06.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S262307AbVFVAVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:21:09 -0400
In-Reply-To: <200506212334.44066.arnd@arndb.de>
References: <200506212310.54156.arnd@arndb.de> <200506212326.18205.arnd@arndb.de> <200506212328.28929.arnd@arndb.de> <200506212334.44066.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dc0a828aec834a05b3b3fd6d4f6e3426@penguinppc.org>
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
From: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH 10/11] ppc64: SPU file system
Date: Tue, 21 Jun 2005 19:21:09 -0500
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.622)
X-ELNK-Trace: 77a46389d001b1f223bcf3e39c2f8b5f1aa676d7e74259b7b3291a7d08dfec7957a29a5ce07feffc8c3ab1d6ac159afc350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 63.246.184.80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 21, 2005, at 4:34 PM, Arnd Bergmann wrote:

> +union MFC_TagSizeClassCmd {

I think great effort has gone in to removing so-called "StudlyCaps" 
from the ppc64 iSeries code... :)

Also, I didn't see "MFC" defined anywhere... it's sort of a pet peeve, 
but could you make sure all your acronyms are defined? Most of them are 
described in spu.h, but a few slipped through I think (like "SMF").

And while a comment at the top of every file is great, ones like this:
> +/*
> + * Low-level SPU handling
> + *
might be more helpful if they defined SPU and further mentioned it's 
the coprocessor in the Broadband Processor Architecture...

-Hollis

