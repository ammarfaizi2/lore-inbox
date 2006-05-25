Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWEYECT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWEYECT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWEYECO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:02:14 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:24663 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964858AbWEYECF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:02:05 -0400
From: David Brownell <david-b@pacbell.net>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: jffs2 build fixes
Date: Wed, 24 May 2006 21:02:00 -0700
User-Agent: KMail/1.7.1
Cc: jffs-dev@axis.com, Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200604010831.57875.david-b@pacbell.net> <200605160755.38606.david-b@pacbell.net> <1147792129.3806.15.camel@pmac.infradead.org>
In-Reply-To: <1147792129.3806.15.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605242102.02466.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 8:08 am, David Woodhouse wrote:
> On Tue, 2006-05-16 at 07:55 -0700, David Brownell wrote:
> > I see that Andrew also got tired of such printk warnings, so his
> > fix is now in the kernel.org tree ... here's a resend of this
> > patch, updated against today's GIT by removing two of the printk
> > warning fixes.
> 
> The other three printk watning fixes don't seem to apply any more
> either. I've committed the __init and __exit bits though. Thanks.

I'm getting section warnings with RC5 building JFFS2 as an x86 module;
the ZLIB compressors it seems.

You might want to push those __init and __exit bits soon ...

- Dave
