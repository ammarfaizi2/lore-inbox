Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbTD3OuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 10:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTD3OuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 10:50:22 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:1292 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262216AbTD3OuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 10:50:21 -0400
Date: Wed, 30 Apr 2003 16:02:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
Message-ID: <20030430160239.A8956@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030430150211.A7024@infradead.org> <200304301457.h3UEvMGi023283@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304301457.h3UEvMGi023283@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Wed, Apr 30, 2003 at 10:57:22AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 10:57:22AM -0400, chas williams wrote:
> i dont believe it needs to be a variadic (the afs syscall will/uses the
> first params).  however, the syscall interface for afs predates linux.
> changing to a different interface just for linux kernels seems somewhat
> costly (programmers time) when this existing interface has been well
> tested and debugged on several other operating systems.

We need to repeat a mistake others did has never been a valid
argument in linux devlopment..  Anyway, it's really hard to judge about
this before seeing the actual implementation instead of just saying
here's a stub I need.
