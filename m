Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbTEGLnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 07:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTEGLnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 07:43:03 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:1160 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263104AbTEGLnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 07:43:03 -0400
Message-Id: <200305071154.h47BsbsD027038@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Date: Wed, 07 May 2003 13:51:11 +0200
References: <20030507104008$12ba@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Only change *needed* in each architecture is moving A() macros into
> compat.h, so that generic code can use it. Please apply,

Please don't use A() in new code, we now have compat_ptr() and
compat_uptr_t for this.

        Arnd <><
