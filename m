Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263404AbTDCPCy>; Thu, 3 Apr 2003 10:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263405AbTDCPCy>; Thu, 3 Apr 2003 10:02:54 -0500
Received: from ns.suse.de ([213.95.15.193]:42501 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263404AbTDCPCx>;
	Thu, 3 Apr 2003 10:02:53 -0500
Date: Thu, 3 Apr 2003 17:14:21 +0200
From: Andi Kleen <ak@suse.de>
To: mikpe@csd.uu.se
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.66] ioctl32 breakage on x86_64
Message-ID: <20030403151420.GA2062@wotan.suse.de>
References: <16012.19083.730422.148040@enequist.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16012.19083.730422.148040@enequist.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 04:51:55PM +0200, mikpe@csd.uu.se wrote:
> IA32 emulation on x86_64 doesn't compile in 2.5.66 due to
> conflicting declarations of sys_ioctl(). The patch below
> is a quick fix to make both the generic ioctl32 one and
> x86_64's private one agree with reality.

Already fixed in my tree, not merged to Linus yet

(see the latest patch on ftp://ftp.x86-64.org/pub/linux/v2.5 and 
the release notes there as usual) 

-Andi
