Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbSKLU1z>; Tue, 12 Nov 2002 15:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbSKLU1z>; Tue, 12 Nov 2002 15:27:55 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:7942 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S266926AbSKLU1z>;
	Tue, 12 Nov 2002 15:27:55 -0500
Date: Tue, 12 Nov 2002 21:34:35 +0100
From: romieu@fr.zoreil.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, werner.almesberger@epfl.ch
Subject: Re: ATM stack locking broken
Message-ID: <20021112213435.A21918@electric-eye.fr.zoreil.com>
References: <1037124679.2774.111.camel@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1037124679.2774.111.camel@zion>; from benh@kernel.crashing.org on Tue, Nov 12, 2002 at 07:11:19PM +0100
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> :
[...]
> I've spent some time trying to figure out why an ATM driver
> I was hacking with kept deadlocking until I figured out the
> problem actually is the kernel ATM stack on SMP.
> 
> spinlock usage in net/atm/* seem to be utterly broken, though
> I don't know the ATM stack well enough myself to fix it quickly,

It's known (for quite some time :o/ )
Don't hold your breath until xmas.

--
Ueimor
