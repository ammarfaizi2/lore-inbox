Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbTEGXIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTEGXGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:06:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41349
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264353AbTEGXGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:06:17 -0400
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305072113.07004.arnd@arndb.de>
References: <20030507104008$12ba@gated-at.bofh.it>
	 <20030507152856.GF412@elf.ucw.cz> <1052323484.9817.14.camel@rth.ninka.net>
	 <200305072113.07004.arnd@arndb.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052346011.3060.62.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 23:20:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-07 at 20:13, Arnd Bergmann wrote:
> Another solution could be to use the tables only if
> ->compat_ioctl() is undefined or returned -ENOTTY. That

We have magic -ENOIOCTLCMD type returns never meant for user space to
handle that ambiguity

