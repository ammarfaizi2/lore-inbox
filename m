Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbTEGO0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTEGO0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:26:42 -0400
Received: from rth.ninka.net ([216.101.162.244]:2985 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263227AbTEGO0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:26:42 -0400
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030507135600.A22642@infradead.org>
References: <20030507104008$12ba@gated-at.bofh.it>
	 <200305071154.h47BsbsD027038@post.webmailer.de>
	 <20030507124113.GA412@elf.ucw.cz>  <20030507135600.A22642@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052318339.9817.8.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 07:39:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 05:56, Christoph Hellwig wrote:
> Btw, if you really want to move all the 32bit ioctl compat code to the
> drivers a ->ioctl32 file operation might be the better choice..

I can't believe I never thought of that. :-)

-- 
David S. Miller <davem@redhat.com>
