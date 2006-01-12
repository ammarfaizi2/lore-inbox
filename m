Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWALFEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWALFEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 00:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWALFEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 00:04:24 -0500
Received: from mx.pathscale.com ([64.160.42.68]:7918 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030283AbWALFEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 00:04:23 -0500
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org
In-Reply-To: <200601120545.34711.ak@suse.de>
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com>
	 <200601120519.12960.ak@suse.de>
	 <1137040361.29795.8.camel@camp4.serpentine.com>
	 <200601120545.34711.ak@suse.de>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 21:04:17 -0800
Message-Id: <1137042258.29795.11.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 05:45 +0100, Andi Kleen wrote:

> > There's also no clean, obvious way to make it work on other 
> > 64-bit architectures, in that case.
> 
> for loop and writel() ? 

But that's what I have now, albeit with a name you don't like and use of
movsq where you'd apparently prefer movsd.  If I resolve those, can it
just live as-is otherwise?  In which case it is no longer doing anything
funny or odd.

	<b

