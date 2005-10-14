Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVJNTIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVJNTIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVJNTIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:08:12 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:47209 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750764AbVJNTIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:08:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=s5z1KSdMjbujX1OVKcx/1ugN5cW41bjWz+zCCfuFoH5vF3t2vRGgYcoQcNHUNDK3eB0qhu5Oi8wzTXFsn8at54jEYGfkB8RPJPy1CTMprMMtPzD2H80L5qQIrMKKORPoxbhbLCNWik+c1Ry4L5w74OHBdFkFu6lKolhC/cP5Grs=
Subject: Re: 2.6.14-rc4-rt4
From: Badari Pulavarty <pbadari@gmail.com>
To: John Rigg <lk@sound-man.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <E1EQUbp-0001Lq-Bh@localhost.localdomain>
References: <E1EQUbp-0001Lq-Bh@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 12:05:53 -0700
Message-Id: <1129316753.6266.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-14 at 19:48 +0100, John Rigg wrote:
> On Fri October 14 Badari Pulavarty wrote:
> 
> >I am able to apply cleanly. I am trying to see if it fixes my problem
> >or not.
> 
> Something in 2.6.14-rc4-rt4 breaks compilation with my config (with or
> without the extra patch) with following error message:
> 
>   CC      kernel/ktimers.o
> kernel/ktimers.c: In function 'check_ktimer_signal':
> kernel/ktimers.c:1100: error: request for member 'tv' in something not a structure or union
> 
> Am about to try applying the change in the patch to -rt1, which I know
> compiles.

It did work for me in -rt1. My machine boots fine with the patch.

Thanks,
Badari

