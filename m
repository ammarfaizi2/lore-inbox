Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUEGCwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUEGCwq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 22:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUEGCwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 22:52:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:21122 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262476AbUEGCwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 22:52:44 -0400
Date: Thu, 6 May 2004 19:52:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bruce Guenter <bruceg@em.ca>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.6-rc3-mm2
Message-Id: <20040506195223.017cd7f6.akpm@osdl.org>
In-Reply-To: <20040506214635.GA29187@em.ca>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<20040506214635.GA29187@em.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Guenter <bruceg@em.ca> wrote:
>
> On Wed, May 05, 2004 at 01:31:35AM -0700, Andrew Morton wrote:
> > Move-saved_command_line-to-init-mainc.patch
> >   Move saved_command_line to init/main.c
> 
> This patch appears to be breaking serial console for me.  Reverting this
> patch with patch -R makes it work again.  I can't tell from the contents
> of the patch why it causes problems, but it does.  I'd be happy to
> provide any further details if required.

Thanks for narrowing it down - I'd been meaning to look into the serial
console problem.

Rusty, can you have a ponder please?
