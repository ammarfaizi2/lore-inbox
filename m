Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUESWBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUESWBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 18:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbUESWBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 18:01:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13064 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264519AbUESWBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 18:01:22 -0400
Date: Wed, 19 May 2004 23:00:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Christoph Hellwig <hch@infradead.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
Message-ID: <20040519230038.B28893@flint.arm.linux.org.uk>
Mail-Followup-To: Tim Bird <tim.bird@am.sony.com>,
	Adrian Bunk <bunk@fs.tum.de>, Christoph Hellwig <hch@infradead.org>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org> <40A92D15.2060006@am.sony.com> <20040519152706.GD22742@fs.tum.de> <40AB925C.50001@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40AB925C.50001@am.sony.com>; from tim.bird@am.sony.com on Wed, May 19, 2004 at 09:59:08AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 09:59:08AM -0700, Tim Bird wrote:
> As for the patch, you are correct that the kernel makefile system
> supports compilation with -Os, and someone besides us submitted
> the patch for that.  However, there is more work needed to
> validate that the option doesn't break things, on many different
> architectures.

Well, on ARM, building with anything other than -Os shows up
compiler bugs in the gcc3 toolchain, so here the only option
is to use -Os.

I guess you can say that means ARM is validated for building
with -Os but not -O2 with 2.6.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
