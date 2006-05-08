Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWEHRZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWEHRZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWEHRZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:25:37 -0400
Received: from mout2.freenet.de ([194.97.50.155]:20387 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932470AbWEHRZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:25:37 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] Twofish cipher i586-asm optimized
Date: Mon, 8 May 2006 19:25:31 +0200
User-Agent: KMail/1.8.3
Cc: yoshfuji@linux-ipv6.org, linux-crypto@vger.kernel.org
References: <200605071156.57844.jfritschi@freenet.de> <200605072247.46655.jfritschi@freenet.de> <20060508.150152.113737945.yoshfuji@linux-ipv6.org>
In-Reply-To: <20060508.150152.113737945.yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605081925.32028.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > After going over my patch again, i realized i missed the .cra_priority
> > and .cra_driver_name setting in the crypto api struct. Here is an updated
> > version of my patch:
> >
> > http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-i586-asm-2.6.1
> >7-2.diff
>
> Any reasons to exclude 64BIT on Kconfig?

This is the patch for i586 and above only (i386 arch). If you want 64bit 
(x86_64 arch) you should take a look at my other patch:

http://homepages.tu-darmstadt.de/~fritschi/twofish/twofish-x86_64-asm-2.6.17-2.diff

Regards,
Joachim
