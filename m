Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292549AbSCDR2L>; Mon, 4 Mar 2002 12:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292584AbSCDR1g>; Mon, 4 Mar 2002 12:27:36 -0500
Received: from gordo.y12.doe.gov ([134.167.141.46]:32739 "EHLO
	gordo.y12.doe.gov") by vger.kernel.org with ESMTP
	id <S292560AbSCDR1Z>; Mon, 4 Mar 2002 12:27:25 -0500
Message-ID: <3C83AE6B.9B5DE85F@y12.doe.gov>
Date: Mon, 04 Mar 2002 12:27:07 -0500
From: David Dillow <dillowd@y12.doe.gov>
Organization: BWXT Y-12/ACT/UT Subcon/What a mess!
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 3)
In-Reply-To: <Pine.LNX.4.33.0203041023580.11065-100000@janetreno.austin.ibm.com> <3C83A925.F93BF448@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Set cache line size just like drivers/net/acenic.c does, and enable
> memory-write-invalidate...

Does this mean the setup pci_enable_device() does on the cache line size
is not sufficient?

I ask, because I've been relying on it for a driver I'm working on;
should I be setting this as acenic does? It would seem that this is
something many drivers would need to do...

Thanks,
Dave Dillow
dillowd@y12.doe.gov
