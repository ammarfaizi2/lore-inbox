Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161424AbWBUISe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161424AbWBUISe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 03:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161430AbWBUISe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 03:18:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161424AbWBUISd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 03:18:33 -0500
Date: Tue, 21 Feb 2006 00:16:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: 2.6.16-rc4-mm1
Message-Id: <20060221001639.1439cc3a.akpm@osdl.org>
In-Reply-To: <43FACBD5.5020309@free.fr>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<43FACBD5.5020309@free.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard <laurent.riffard@free.fr> wrote:
>
> Le 20.02.2006 13:26, Andrew Morton a écrit :
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
> > 
> [snip]
> >  git-viro-bird.patch
> [snip]
> 
> This one seems to break ne2k-pci for me. Kernel gets an 
> oops when the module is inserted. Reverting git-viro-bird* 
> solves the problem.
> 
> ...
>
>  [pg0+548873907/1069843456] NS8390_init+0x8/0xa [8390]

That might be me.  I had to put a nasty-looking hack in there to make it
compile.

