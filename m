Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSG3Vsr>; Tue, 30 Jul 2002 17:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSG3Vsr>; Tue, 30 Jul 2002 17:48:47 -0400
Received: from mta04ps.bigpond.com ([144.135.25.136]:53476 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316728AbSG3Vsq>; Tue, 30 Jul 2002 17:48:46 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
Date: Wed, 31 Jul 2002 07:47:35 +1000
User-Agent: KMail/1.4.5
Cc: Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
References: <Pine.GSO.4.21.0207301738090.6010-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0207301738090.6010-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207310747.35605.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002 07:42, Alexander Viro wrote:
<snip>
> Strictly speaking, there might be a DISadvantage - IIRC, there's nothing to
> stop gcc from
> #define uint8_t unsigned long long	/* it is at least 8 bits */
Here is an extract from <linux/types.h>
typedef         __u8            uint8_t;
typedef         __u16           uint16_t;

> ICBW, but wasn't uint<n>_t only promised to be at least <n> bits?
I am not sure I understand the point you are trying to make.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
