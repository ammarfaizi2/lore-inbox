Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266047AbTFWODf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 10:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266051AbTFWODf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 10:03:35 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:8722 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266047AbTFWODe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 10:03:34 -0400
Date: Mon, 23 Jun 2003 15:17:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] loop.c - part 1 of many
Message-ID: <20030623151740.A25703@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200306230859.h5N8xZ811407.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200306230859.h5N8xZ811407.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Jun 23, 2003 at 10:59:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 10:59:35AM +0200, Andries.Brouwer@cwi.nl wrote:
> >>> IMHO we should replace it with a by-name selection
> 
> >> That is what CryptoAPI does
> 
> > CryptoAPI did _not_ replace it but add another level of indirection
> 
> Right. That is backwards compatibility for you.

The only backwards-compatiblity we care for in mainline is
XOR and special-casing that is trivial, we don't even need to support
anything else with the by magic number ioctl.  In fact I wonder
whether we should care for X0R - I know of exactly one real-life use...

