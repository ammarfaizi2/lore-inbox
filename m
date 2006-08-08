Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWHHGUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWHHGUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWHHGUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:20:30 -0400
Received: from koto.vergenet.net ([210.128.90.7]:48526 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751246AbWHHGUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:20:30 -0400
Date: Tue, 8 Aug 2006 15:09:58 +0900
From: Horms <horms@verge.net.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@in.ibm.com,
       fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060808060957.GC7681@verge.net.au>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <20060804225611.GG19244@in.ibm.com> <m1k65onleq.fsf@ebiederm.dsl.xmission.com> <20060808033405.GA6767@verge.net.au> <44D813D7.3050004@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D813D7.3050004@zytor.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 09:32:23PM -0700, H. Peter Anvin wrote:
> Horms wrote:
> >
> >I also agree that it is non-intitive. But I wonder if a cleaner
> >fix would be to remove CONFIG_PHYSICAL_START all together. Isn't
> >it just a work around for the kernel not being relocatable, or
> >are there uses for it that relocation can't replace?
> >
> 
> Yes, booting with the 2^n existing bootloaders.

Ok, I must be confused then. I though CONFIG_PHYSICAL_START was
introduced in order to allow an alternative address to be provided for
kdump, and that previously it was hard-coded to some
architecture-specific value.

What I was really getting as is if it needs to be configurable at
compile time or not. Obviously there needs to be some sane default
regardless.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

