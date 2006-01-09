Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWAIVUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWAIVUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWAIVUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:20:22 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:36617 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750726AbWAIVUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:20:21 -0500
Date: Mon, 9 Jan 2006 22:20:05 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Eric Sandeen <sandeen@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
Message-ID: <20060109212005.GC14477@mars.ravnborg.org>
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org> <43C2CFBD.8040901@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C2CFBD.8040901@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 03:03:57PM -0600, Eric Sandeen wrote:
 
> Out of curiosity, what's the reason to drop VERSION & PATCHLEVEL... seems 
> handy if you have a common body of code that needs to build for various 
> kernels, with various Makefiles to suit.  As above. :)
The kernel is supposed to hold the code for the kernel - not a lot of
backward compatibiliy cruft.
In many places they were used to define KERNELRELEASE - but wrongly
since definition of KERNELRELEASE has changed.

	Sam
