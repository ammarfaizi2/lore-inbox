Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUEGERX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUEGERX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 00:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUEGERX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 00:17:23 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:49284 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262882AbUEGERV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 00:17:21 -0400
Subject: Re: 2.6.6-rc3-mm2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Bruce Guenter <bruceg@em.ca>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040506195223.017cd7f6.akpm@osdl.org>
References: <20040505013135.7689e38d.akpm@osdl.org>
	 <20040506214635.GA29187@em.ca>  <20040506195223.017cd7f6.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1083903398.7481.43.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 May 2004 14:16:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-07 at 12:52, Andrew Morton wrote:
> Bruce Guenter <bruceg@em.ca> wrote:
> >
> > On Wed, May 05, 2004 at 01:31:35AM -0700, Andrew Morton wrote:
> > > Move-saved_command_line-to-init-mainc.patch
> > >   Move saved_command_line to init/main.c
> > 
> > This patch appears to be breaking serial console for me.  Reverting this
> > patch with patch -R makes it work again.  I can't tell from the contents
> > of the patch why it causes problems, but it does.  I'd be happy to
> > provide any further details if required.
> 
> Thanks for narrowing it down - I'd been meaning to look into the serial
> console problem.
> 
> Rusty, can you have a ponder please?

Works for me: I use serial console.  Config please.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

