Return-Path: <linux-kernel-owner+w=401wt.eu-S1750780AbXACNxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbXACNxK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbXACNxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:53:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34758 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbXACNxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:53:08 -0500
Subject: Re: [PATCH] quiet MMCONFIG related printks
From: Arjan van de Ven <arjan@infradead.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200701012101.38427.jbarnes@virtuousgeek.org>
References: <200701012101.38427.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 03 Jan 2007 05:53:06 -0800
Message-Id: <1167832386.3095.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 21:01 -0800, Jesse Barnes wrote:
> Using MMCONFIG for PCI config space access is simply an optimization, not
> a requirement.  Therefore, when it can't be used, there's no need for
> KERN_ERR level message.  This patch makes the message a KERN_INFO instead
> to reduce some of the noise in a kernel boot with the 'quiet' option.
> (Note that this has no effect on a normal boot, which is ridiculously
> verbose these days.)


this is wrong, please leave this loud complaint in...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

