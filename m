Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVIGP6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVIGP6t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVIGP6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:58:49 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:32787 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751220AbVIGP6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 11:58:48 -0400
Date: Wed, 7 Sep 2005 11:51:49 -0400
From: Jeff Dike <jdike@addtoit.com>
To: viro@ZenIV.linux.org.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus symbol used in arch/um/os-Linux/elf_aux.c
Message-ID: <20050907155149.GB6601@ccure.user-mode-linux.org>
References: <20050906213351.GC5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906213351.GC5155@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 10:33:51PM +0100, viro@ZenIV.linux.org.uk wrote:
> elf_aux is userland code; it uses symbol (ELF_CLASS) that doesn't exist in
> userland headers; pulled into kernel-offsets.h, switched elf_aux to using it.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Jeff Dike <jdike@addtoit.com>

Thanks, Al.

				Jeff
