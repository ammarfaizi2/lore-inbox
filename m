Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270484AbTHGVMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270501AbTHGVMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:12:39 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:42512 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270484AbTHGVMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:12:38 -0400
Date: Thu, 7 Aug 2003 23:12:36 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030807211236.GA5637@win.tue.nl>
References: <20030806150335.GA5430@gondor.com> <20030807110641.GA31809@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807110641.GA31809@gondor.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 01:06:41PM +0200, Jan Niehusmann wrote:

> Are there any known problems with huge hard disks (250GB) on
> Promise IDE?

Funny. Just yesterday or so I was going through old IDE notes
and discarding all that was outdated. Quoting from memory:

Andre: PDC 20265 pukes in 48-bit DMA clean in PIO primary -
secondary is OK.

Last September or so there was a long discussion about a
filesystem that was destroyed. But what I recall is that
in the end it turned out not to be a hardware problem,
but a precedence problem - two missing parentheses in the driver.

Google will tell you all, I suppose. Search for Promise and Isely.

