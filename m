Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289148AbSAMMUt>; Sun, 13 Jan 2002 07:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289165AbSAMMUk>; Sun, 13 Jan 2002 07:20:40 -0500
Received: from dsl-213-023-060-153.arcor-ip.net ([213.23.60.153]:14090 "HELO
	spot.local") by vger.kernel.org with SMTP id <S289148AbSAMMUV>;
	Sun, 13 Jan 2002 07:20:21 -0500
Date: Sun, 13 Jan 2002 13:23:05 +0100
From: Oliver Feiler <kiza@gmx.net>
To: Duncan Laurie <void@sun.com>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linuxdiskcert.org>
Subject: Re: HPT370 controller set wrong udma mode
Message-ID: <20020113132305.A239@gmxpro.net>
In-Reply-To: <20020113054705.GA2160@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020113054705.GA2160@sun.com>; from void@sun.com on Sat, Jan 12, 2002 at 09:47:05PM -0800
X-Operating-System: Linux 2.4.16 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Laurie wrote:
> 
> Try this patch... apply it after the latest patch from Andre becuase that 
> includes several other crucial highpoint fixes.  It looks like the cable
> detect pins are also used as address lines and so must be configured as
> inputs to read valid cable detect state.

	That solved the problem. Thank you.

Oliver

-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
