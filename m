Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269683AbUJGEUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269683AbUJGEUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 00:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbUJGEUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 00:20:39 -0400
Received: from havoc.gtf.org ([69.28.190.101]:64683 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269683AbUJGEU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 00:20:28 -0400
Date: Thu, 7 Oct 2004 00:20:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt_Domsch@dell.com, linux-kernel@vger.kernel.org, alan@redhat.com,
       david.balazic@hermes.si
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
Message-ID: <20041007042026.GA18890@havoc.gtf.org>
References: <20041004214803.GC2989@lists.us.dell.com> <4164BF82.2040608@pobox.com> <20041006211605.17c1cb41.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006211605.17c1cb41.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 09:16:05PM -0700, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > > This also adds CONFIG_EDD_SKIP_MBR to eliminate reading the MBR on
> >  > each BIOS-presented disk, in case there are further problems in this
> >  > area.
> > 
> > 
> >  Build fails on x86-64:
> > 
> >  [...]
> >     SYSMAP  System.map
> >     SYSMAP  .tmp_System.map
> >     AS      arch/x86_64/boot/setup.o
> >  In file included from arch/x86_64/boot/setup.S:536:
> >  arch/i386/boot/edd.S:17: macro names must be identifiers
> >  make[1]: *** [arch/x86_64/boot/setup.o] Error 1
> >  make: *** [bzImage] Error 2
> 
> hm, works OK here.
> 
> Is it missing config.h?

Maybe I was being foolish by applying the patch to mainline ;-)

	Jeff



