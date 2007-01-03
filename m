Return-Path: <linux-kernel-owner+w=401wt.eu-S1750973AbXACRUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbXACRUr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbXACRUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:20:47 -0500
Received: from outbound-mail-73.bluehost.com ([69.89.20.8]:44495 "HELO
	outbound-mail-73.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750973AbXACRUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:20:46 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] quiet MMCONFIG related printks
Date: Wed, 3 Jan 2007 09:20:49 -0800
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200701012101.38427.jbarnes@virtuousgeek.org> <1167832386.3095.20.camel@laptopd505.fenrus.org>
In-Reply-To: <1167832386.3095.20.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701030920.49991.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 3, 2007 5:53 am, Arjan van de Ven wrote:
> On Mon, 2007-01-01 at 21:01 -0800, Jesse Barnes wrote:
> > Using MMCONFIG for PCI config space access is simply an
> > optimization, not a requirement.  Therefore, when it can't be used,
> > there's no need for KERN_ERR level message.  This patch makes the
> > message a KERN_INFO instead to reduce some of the noise in a kernel
> > boot with the 'quiet' option. (Note that this has no effect on a
> > normal boot, which is ridiculously verbose these days.)
>
> this is wrong, please leave this loud complaint in...

Or maybe the test is just wrong.  I'll try out the PCI MMConfig 
per-chipset patches to see if they work.  That seems like a better long 
term solution anyway.

Thanks,
Jesse
