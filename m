Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbTFUPmr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 11:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTFUPmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 11:42:47 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:5895 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264895AbTFUPmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 11:42:46 -0400
Date: Sat, 21 Jun 2003 16:56:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, axboe@suse.de, clemens@endorphin.org,
       torvalds@transmeta.com, jari.ruusu@pp.inet.fi,
       linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: [PATCH - RFC] loop.c
Message-ID: <20030621165639.A27091@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, akpm@digeo.com, axboe@suse.de,
	clemens@endorphin.org, torvalds@transmeta.com,
	jari.ruusu@pp.inet.fi, linux-kernel@vger.kernel.org,
	hugh@veritas.com
References: <UTC200306211507.h5LF7lM23701.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200306211507.h5LF7lM23701.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Jun 21, 2003 at 05:07:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 05:07:47PM +0200, Andries.Brouwer@cwi.nl wrote:
> Concerning the second point, several patches are floating around.
> Below a patch that Jari Ruusu sent me.
> 
> This is a RFC.
> Clemens - any comments on the crypto side?
> Jens - any comments on the block I/O side?

The patch is far too big and mixes up very different issues.  Let's
change one thing at a time.  There's was a small patch for the IV
issue posted, let's get that in first and base small, reviewable patches
on it.  You also might want to Cc'ed Hugh as he did some work on
loop.c recently..

