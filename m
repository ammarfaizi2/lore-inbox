Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTD3P0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTD3P0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:26:11 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:25356 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262298AbTD3P0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:26:08 -0400
Date: Wed, 30 Apr 2003 16:38:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
Message-ID: <20030430163827.B9495@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030430162739.A9255@infradead.org> <200304301533.h3UFXvGi023489@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304301533.h3UFXvGi023489@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Wed, Apr 30, 2003 at 11:33:57AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 11:33:57AM -0400, chas williams wrote:
> In message <20030430162739.A9255@infradead.org>,Christoph Hellwig writes:
> >So fix the AFS code up to use a routine for each subcall that
> >can still map to pioctl for !linux.  After that we can continue the
> >discussion on how these calls are best implemented on linux.
> 
> because time is precious its quite a bit easier to fix one spot in 
> the linux kernel than to fix a hundred or so in the afs code.

It might be easier but it's not the correct fix.  I've we had done what's
easier all the time Linux would look like SCO Unix or IRIX now..
