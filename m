Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVECMz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVECMz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 08:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVECMzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 08:55:55 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:52484 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261510AbVECMzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 08:55:46 -0400
Date: Mon, 2 May 2005 23:03:29 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/22] UML - Include the linker script rather than symlink it
Message-ID: <20050503030329.GA17992@ccure.user-mode-linux.org>
References: <200505012112.j41LC9fa016385@ccure.user-mode-linux.org> <20050502170654.248b11ea.akpm@osdl.org> <20050503002521.GA18977@parcelfarce.linux.theplanet.co.uk> <20050502174405.0c8cad31.akpm@osdl.org> <20050503011744.GC18977@parcelfarce.linux.theplanet.co.uk> <20050502182851.27f22470.akpm@osdl.org> <20050503014543.GD18977@parcelfarce.linux.theplanet.co.uk> <20050502190250.45e37457.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502190250.45e37457.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 07:02:50PM -0700, Andrew Morton wrote:
> OK, did that.  Had one reject against
> uml-kbuild-avoid-useless-rebuilds.patch, but 'twas easily fixed.

Thanks.  Sorry about the hassle.  The vmlinux.lds botch was a symptom of
the problem Al was fixing (the uncleaned symlink in my tree causing a reject
in a clean tree), and the missing mk_sc patch was just an oversight on my
part.

				Jeff
