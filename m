Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVCNWEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVCNWEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVCNWC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:02:59 -0500
Received: from relay.axxeo.de ([213.239.199.237]:10632 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261983AbVCNV6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:58:42 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Matthew Wilcox <willy@parisc-linux.org>
Subject: Re: [PATCH] Releasing resources with children
Date: Mon, 14 Mar 2005 22:49:10 +0100
User-Agent: KMail/1.7.1
References: <20050314174916.B49754957B9@palinux.hppa> <20050314181108.A4705@flint.arm.linux.org.uk>
In-Reply-To: <20050314181108.A4705@flint.arm.linux.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, matthew@wil.cx
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503142249.11107.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> The only thing I'd question is whether we really need to BUG_ON() here.
> ISTR Linus' policy for BUG()/BUG_ON() was only if the condition lead
> directly to a filesystem-corrupting bug.

I consider it quite effective to flag interface violations.
Programming by contract anyone? ;-)

Regards

Ingo Oeser

