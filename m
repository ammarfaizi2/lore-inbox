Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264588AbUESV5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbUESV5g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 17:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbUESV5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 17:57:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9736 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264588AbUESV5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 17:57:35 -0400
Date: Wed, 19 May 2004 22:57:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Mark Gross <mgross@linux.jf.intel.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
Message-ID: <20040519225729.A28893@flint.arm.linux.org.uk>
Mail-Followup-To: Tim Bird <tim.bird@am.sony.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mark Gross <mgross@linux.jf.intel.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org> <200405171342.49891.mgross@linux.intel.com> <20040518074854.A7348@infradead.org> <40ABB5E2.3040908@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40ABB5E2.3040908@am.sony.com>; from tim.bird@am.sony.com on Wed, May 19, 2004 at 12:30:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 12:30:42PM -0700, Tim Bird wrote:
> The non-normative section of this spec. explains where this was
> a problem in 2.4, and why it is desirable, from the standpoint of
> bootup time reduction, to avoid these busywaits.

In this case, it's really a bug that IDE is using a busy wait where it
should be using a sleeping wait.  It's a bug, plain and simple.  To
wrap the bug into "a spec" somehow seems wrong to me, especially when
it would be far better to report the problem as a bug.

Sure, specs make suit-wearing people happy, but that doesn't mean that
they're appropriate as a bug reporting method. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
