Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVAEKNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVAEKNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 05:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVAEKNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 05:13:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:39637 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262313AbVAEKNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 05:13:22 -0500
Date: Wed, 5 Jan 2005 02:13:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marat BN <maratbn@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops
Message-Id: <20050105021307.3664b21c.akpm@osdl.org>
In-Reply-To: <20050103211024.21792.qmail@web53708.mail.yahoo.com>
References: <20050103211024.21792.qmail@web53708.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marat BN <maratbn@yahoo.com> wrote:
>
> Please find the attached text files containing 2.6.10
>  kernel Oops messages 
>  sent out by the kernel to via the serial port.  The
>  2.6.10 kernel was 
>  compiled with all debugging support enabled.  It was
>  running on a Gentoo 
>  machine.
> 
>  At the time of the Oops, one process was doing
>  iterations of capturing 100 
>  frames each via BTTV and another was tar untarring a
>  huge file.

Nasty slab corruption.  Is it repeatable?  I'd be suspecting the bttv
operation is the cause - if you repeat that operation does the system again
fail?

