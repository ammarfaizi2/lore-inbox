Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269312AbUIYL5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269312AbUIYL5b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 07:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUIYL5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 07:57:31 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:35858 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269312AbUIYLx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 07:53:56 -0400
Date: Sat, 25 Sep 2004 12:53:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Reproducable DoS with NFS+XFS under 2.6.{5,8.1}
Message-ID: <20040925125351.A4473@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <Pine.LNX.4.61.0409250642050.19470@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0409250642050.19470@p500>; from jpiszcz@lucidpixels.com on Sat, Sep 25, 2004 at 06:45:36AM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 06:45:36AM -0400, Justin Piszcz wrote:
> Two issues.
> 
> 1 - With 2.6.5
> 2 - With 2.6.8.1
> 
> 1 - I have the actual oops.
> 2 - Reproducable every time I do it but I'd have to copy the panic off the
>      screen which isn't entirely there.
> 
> 
> Problem 1: If you try to copy a file off of an NFS share while it is being 
> written:

This should be fixed in XFS cvs at oss.sgi.com, and will be merged to
mainline soon.

