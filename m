Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268577AbUIQIlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268577AbUIQIlZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 04:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUIQIlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 04:41:25 -0400
Received: from relay.pair.com ([209.68.1.20]:43025 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268577AbUIQIlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 04:41:15 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <414AA2CA.5080201@kegel.com>
Date: Fri, 17 Sep 2004 01:39:38 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix allnoconfig on arm with small tweak to kconfig?
References: <414551FD.4020701@kegel.com> <20040913091534.B27423@flint.arm.linux.org.uk> <4145BB30.60309@kegel.com> <20040913195119.B4658@flint.arm.linux.org.uk> <41464C8E.3060004@kegel.com> <20040914092951.A15258@flint.arm.linux.org.uk>
In-Reply-To: <20040914092951.A15258@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> last time I built a pure bk-based tree (4 days ago), the following worked:
> 
> - ebsa110
> - netwinder
> - imx
> - integrator
> - lubbock
> - rpc
> - s3c2410
> - versatile
> 
 > ... So
> $ make netwinder_defconfig
> $ make
> 
> will build a working kernel.

OK, I've given up entirely on allnoconfig, and simply ran 'make netwinder_defconfig'
once by hand to capture a working arm config file
(since I already lug around config files).   This lets me avoid special-casing arm,
and seems to work ok.

Sorry for the noise.
- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
