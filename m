Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUAIPPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUAIPPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:15:00 -0500
Received: from ns.suse.de ([195.135.220.2]:19664 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261973AbUAIPO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:14:58 -0500
To: Paul Jackson <pj@sgi.com>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, joe.korty@ccur.com,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040109064619.35c487ec.pj@sgi.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Edwin Meese made me wear CORDOVANS!!
Date: Fri, 09 Jan 2004 16:14:55 +0100
In-Reply-To: <20040109064619.35c487ec.pj@sgi.com> (Paul Jackson's message of
 "Fri, 9 Jan 2004 06:46:19 -0800")
Message-ID: <je1xq9duhc.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> This would be defined in the include/asm-sparc64/cpumask.h and
> include/asm-ppc64/cpumask.h files, with a no-op default in the
> include/asm-generic/cpumask.h file for other architectures that
> don't need it. 

S390x is big-endian, too.  IMHO it should rather be in
include/linux/byteorder, or derived from the macros in there.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
