Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290578AbSBFOhP>; Wed, 6 Feb 2002 09:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290586AbSBFOhF>; Wed, 6 Feb 2002 09:37:05 -0500
Received: from [195.163.186.27] ([195.163.186.27]:29657 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S290578AbSBFOgr>;
	Wed, 6 Feb 2002 09:36:47 -0500
Date: Wed, 6 Feb 2002 16:36:33 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Shiva Raman Pandey <shiva@sasken.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Router Discovery Messages
Message-ID: <20020206163633.B20396@mea-ext.zmailer.org>
In-Reply-To: <a3r2k6$rk3$1@ncc-z.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3r2k6$rk3$1@ncc-z.sasken.com>; from shiva@sasken.com on Wed, Feb 06, 2002 at 04:37:21PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 04:37:21PM +0530, Shiva Raman Pandey wrote:
> Can any body tell me, whether the ICMP Router Discovery Messages (RFC 1256)
> are implemented in Linux kernel code of version 2.2.14 or 2.4.9 or not?
> If yes then in which .c file(s) and .h(files) ?

   It is not supported in kernel.
   It is alike BOOTP/DHCP client, fully implementable in usermode process.

   To be exact, RFC 1256 predates BOOTP, which was created to solve this
   same problem, plus a bunch of other issues.  The DHCP is just refinement
   of BOOTP.

> Regards
> Shiva

/Matti Aarnio
