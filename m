Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161361AbWJ3TRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161361AbWJ3TRG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161432AbWJ3TRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:17:06 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:19853 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1161361AbWJ3TRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:17:03 -0500
Date: Mon, 30 Oct 2006 15:14:54 -0500
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] uml ubd driver: var renames
Message-ID: <20061030201454.GA6079@ccure.user-mode-linux.org>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan> <20061029192029.12292.15703.stgit@americanbeauty.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061029192029.12292.15703.stgit@americanbeauty.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 08:20:29PM +0100, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> and then call any "struct ubd" ubd_dev instead of dev, which doesn't
> make clear what we're treating (and no, it's not hungarian notation -
> not any more than calling all vm_area_struct vma or all inodes
> inode).

I can't say that I like this part of it.  I don't see any alternate
interpretation of a variable called 'dev', and renaming it to
'ubd_dev' seems redundant, given that we are in the ubd driver.

Plus, this change sent a couple of lines over the 80-character
boundary.

				Jeff

Work email - jdike at linux dot intel dot com
