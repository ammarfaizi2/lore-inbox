Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWIOI2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWIOI2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWIOI2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:28:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55495 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750736AbWIOI2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:28:42 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Date: Fri, 15 Sep 2006 08:43:11 +0200
User-Agent: KMail/1.9.1
Cc: Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org
References: <20060913065010.GA2110@ff.dom.local> <200609141212.50636.ak@suse.de> <20060914160814.GA27313@redhat.com>
In-Reply-To: <20060914160814.GA27313@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609150843.12007.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 September 2006 18:08, Dave Jones wrote:
> On Thu, Sep 14, 2006 at 12:12:50PM +0200, Andi Kleen wrote:
>  > On Wednesday 13 September 2006 18:42, Dave Jones wrote:
>  > > On Wed, Sep 13, 2006 at 08:50:10AM +0200, Jarek Poplawski wrote:
>  > >  > Probably after 2.6.18-rc6-git1 there is this cc warning:
>  > >  > "arch/i386/kernel/mpparse.c:231: warning: comparison is
>  > >  > always false due to limited range of data type".
>  > >  > Maybe this patch will be helpful.
>  >
>  > It's already fixed.
>  >
>  > -Andi
>
> Still looks busted to me in 2.6.18rc7

Fixed in the queued for 2.6.19 tree. I didn't consider it important enough
to move up.

-Andi
