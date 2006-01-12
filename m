Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWALPyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWALPyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWALPyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:54:22 -0500
Received: from cantor2.suse.de ([195.135.220.15]:35982 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751408AbWALPyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:54:22 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
Date: Thu, 12 Jan 2006 16:54:07 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com> <200601120545.34711.ak@suse.de> <1137042258.29795.11.camel@camp4.serpentine.com>
In-Reply-To: <1137042258.29795.11.camel@camp4.serpentine.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121654.07613.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 06:04, Bryan O'Sullivan wrote:
> On Thu, 2006-01-12 at 05:45 +0100, Andi Kleen wrote:
> 
> > > There's also no clean, obvious way to make it work on other 
> > > 64-bit architectures, in that case.
> > 
> > for loop and writel() ? 
> 
> But that's what I have now, albeit with a name you don't like and use of
> movsq where you'd apparently prefer movsd.  If I resolve those, can it
> just live as-is otherwise?  In which case it is no longer doing anything
> funny or odd.

Yes probably.

-Andi
