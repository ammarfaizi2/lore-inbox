Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWBFCTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWBFCTn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 21:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWBFCTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 21:19:43 -0500
Received: from pat.uio.no ([129.240.130.16]:20154 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750778AbWBFCTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 21:19:43 -0500
Subject: Re: nfsroot doesn't work with intel card since 2.6.12.2/2.6.11
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Carlos Carvalho <carlos@fisica.ufpr.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060205215455.7622B1C8E46@fisica.ufpr.br>
References: <20060205215455.7622B1C8E46@fisica.ufpr.br>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 21:19:30 -0500
Message-Id: <1139192370.7870.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.319, required 12,
	autolearn=disabled, AWL 1.49, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-05 at 19:54 -0200, Carlos Carvalho wrote:
> We have several machines with Intel Corp. 82544EI Gigabit Ethernet
> Controller (Copper) (rev 02), as reported by lspci. They don't manage
> to mount the rootfs via nfs anymore. I've tried several combinations
> and the last one that works is 2.6.12.2 using the 2.6.11 version of
> the driver (simply replacing the files in the tree). 2.6.12.2 with its
> own driver doesn't work.
> 
> There seems to be a pattern: at each version the machine has more
> difficulty mounting the rootfs. Other machines using other ethercards
> but with the same server and filesystem work normally.
> 
> This is a showstopper for us since we cannot upgrade the kernel.
> 
> The same problem happens with 2.4, and the last combination that
> manages to boot is 2.4.32-pre1 with the 2.4.30 driver.
> 
> Any hints?

Not easy, given that you've told us nothing about your actual setup.
However at a quick guess: have you tried the 'tcp' mount option?

Cheers,
  Trond

