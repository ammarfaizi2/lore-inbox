Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276764AbRJKTq5>; Thu, 11 Oct 2001 15:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276766AbRJKTqr>; Thu, 11 Oct 2001 15:46:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58118 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276764AbRJKTqa>; Thu, 11 Oct 2001 15:46:30 -0400
Subject: Re: Unconditional include of <linux/module.h> in aic7xxx driver
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Thu, 11 Oct 2001 20:52:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110111940.f9BJe8Y97938@aslan.scsiguy.com> from "Justin T. Gibbs" at Oct 11, 2001 01:40:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rlsk-0004Vf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> unconditional in the aic7xxx driver?  Assuming MODULE_LICENSE is
> properly qualified by an #ifdef MODULE, the driver appears to compile
> and function correctly without this include.  Are MODULE attributes
> (MODULE_VERSION/AUTHOR/DESCRIPTION/etc.) now supposed to be included in
> static configurations?

It's always been meant to work always included. For non modules it defines
the right do nothing handlers to avoid you having to get ifdefs into the
kernel code
