Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUBMBXc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266677AbUBMBXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:23:32 -0500
Received: from mail.shareable.org ([81.29.64.88]:13698 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266648AbUBMBXa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:23:30 -0500
Date: Fri, 13 Feb 2004 01:23:26 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213012326.GA25499@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402130216.53434.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Rosenberg wrote:
> Is there a place to store character set information in these file systems?

Please don't confuse character set with character encoding.  The
problem we are talking about here is about character encoding.

Once upon a time the two were muddled; that's why MIME and HTTP use
"charset" to mean character encoding.

And the answer is: yes, you can store it wherever you want :)

> Some apps simply don't think non-ascii is relevant. Xmms is one, although
> is doesn't crash at least. My guess was that it was a font problem since it
> looks like XMMS uses some special fonts.

It's not a font problem.  XMMS simply displays each byte as a separate
character because that's what it assumes it should do.  No font will fix that.

-- Jamie
