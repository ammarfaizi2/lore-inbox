Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTKFVbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTKFVbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:31:16 -0500
Received: from rth.ninka.net ([216.101.162.244]:54401 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263794AbTKFVbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:31:15 -0500
Date: Thu, 6 Nov 2003 14:31:10 -0800
From: "David S. Miller" <davem@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
Message-Id: <20031106143110.6231ecde.davem@redhat.com>
In-Reply-To: <boebkn$pmv$1@cesium.transmeta.com>
References: <1068140199.12287.246.camel@nosferatu.lan>
	<1068149368.12287.331.camel@nosferatu.lan>
	<20031106120548.097ccc7c.davem@redhat.com>
	<1068150552.12287.349.camel@nosferatu.lan>
	<boebkn$pmv$1@cesium.transmeta.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Nov 2003 12:40:55 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> Note that "long long" (the underlying type) is valid
> standards-compliant C99.  gcc can handle it when in C89 mode if
> defined as __extension__ long long IIRC.

That's correct and I've suggested this.

But keep in mind that people with non-GCC compilers will then
start complaining.
