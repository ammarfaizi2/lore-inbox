Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSKNR12>; Thu, 14 Nov 2002 12:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbSKNR12>; Thu, 14 Nov 2002 12:27:28 -0500
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:32269 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S265140AbSKNR11>;
	Thu, 14 Nov 2002 12:27:27 -0500
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
From: Ray Lee <ray-lk@madrabbit.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: hps@intermeta.de, schwab@suse.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0211122241490.29595-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0211122241490.29595-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1037295254.27832.11.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 14 Nov 2002 09:34:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for taking so long to review something so short, btw.)

On Tue, 2002-11-12 at 23:06, Randy.Dunlap wrote:
> On 11 Nov 2002, Ray Lee wrote:
> | Explicitly, in the scan conversion you'd do a:
> |   unsigned int *u = (unsigned int *) va_arg(args,long long *);
> |   *u = (unsigned int) converted_value;

(Luckily you didn't follow my code snippet too closely. Oops.)

> See if this is close...
<snip>
> I think that this patch (to 2.5.47) gets the kernel close
> to the same semantics as C's sscanf() function, which is
> usually a good thing.  What say you?

The sample conversions and patch look correct. Time to forward it
onward, me thinks.

Ray

