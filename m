Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbVKPV5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbVKPV5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbVKPV5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:57:24 -0500
Received: from pat.uio.no ([129.240.130.16]:39843 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030521AbVKPV5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:57:23 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051116214137.16970.qmail@web34102.mail.mud.yahoo.com>
References: <20051116214137.16970.qmail@web34102.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 16:57:14 -0500
Message-Id: <1132178234.8811.64.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.896, required 12,
	autolearn=disabled, AWL 1.10, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 13:41 -0800, Kenny Simpson wrote:
> --- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > 
> > Is this NFSv2?
> > 
> > Cheers,
> >   Trond
> > 
> This is reproducible with O_DIRECT, but not without.

I'm getting lost here. Please could you spell out the testcases that are
not working.

Are you saying that the combination mmap() + pwrite64() fails on
O_DIRECT, but works on ordinary open, and that mmap() + ftruncate64()
always works?

Cheers,
  Trond

