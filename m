Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTLLIqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 03:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbTLLIqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 03:46:51 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:19911 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264444AbTLLIqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 03:46:50 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@hpl.hp.com>, jbarnes@sgi.com,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] quite down SMP boot messages
References: <yq0fzfr32ib.fsf@wildopensource.com>
	<20031211194818.A25999@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 12 Dec 2003 03:46:41 -0500
In-Reply-To: <20031211194818.A25999@infradead.org>
Message-ID: <yq01xra5spa.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Thu, Dec 11, 2003 at 08:30:52AM -0500, Jes Sorensen
Christoph> wrote:
>> Once you hit > 2 CPUs the amount of noise printed per CPU starts
>> becoming a pain, at 64 CPUs it's turning into a royal pain ....
>> 
>> Oh and I also killed a NULL initializer in kernel/cpu.c - bad Rusty
>> ;-)

Christoph> Just kill the silly option, these messages are completly
Christoph> useless.  And IIRC we didn't have them in 2.4 either..

Some of them I agree could just be killed while others still have some
use. Thats why I suggest leaving in the boot option.

Jes
