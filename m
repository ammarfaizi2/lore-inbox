Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUAIPZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUAIPZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:25:50 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:59144 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262153AbUAIPZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:25:46 -0500
Date: Fri, 9 Jan 2004 15:25:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Paul Jackson <pj@sgi.com>, Paul Mackerras <paulus@samba.org>,
       akpm@osdl.org, joe.korty@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040109152533.A25396@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Schwab <schwab@suse.de>, Paul Jackson <pj@sgi.com>,
	Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
	joe.korty@ccur.com, linux-kernel@vger.kernel.org
References: <20040107165607.GA11483@rudolph.ccur.com> <20040107113207.3aab64f5.akpm@osdl.org> <20040108051111.4ae36b58.pj@sgi.com> <16381.57040.576175.977969@cargo.ozlabs.ibm.com> <20040109064619.35c487ec.pj@sgi.com> <je1xq9duhc.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <je1xq9duhc.fsf@sykes.suse.de>; from schwab@suse.de on Fri, Jan 09, 2004 at 04:14:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 04:14:55PM +0100, Andreas Schwab wrote:
> Paul Jackson <pj@sgi.com> writes:
> 
> > This would be defined in the include/asm-sparc64/cpumask.h and
> > include/asm-ppc64/cpumask.h files, with a no-op default in the
> > include/asm-generic/cpumask.h file for other architectures that
> > don't need it. 
> 
> S390x is big-endian, too.  IMHO it should rather be in
> include/linux/byteorder, or derived from the macros in there.

Yes, we'll need it for mips, too.

