Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267186AbSKPBjb>; Fri, 15 Nov 2002 20:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbSKPBjb>; Fri, 15 Nov 2002 20:39:31 -0500
Received: from fmr03.intel.com ([143.183.121.5]:61176 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267186AbSKPBja>; Fri, 15 Nov 2002 20:39:30 -0500
To: rddunlap@osdl.org ("Randy.Dunlap")
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reserving "special" port numbers in the kernel ?
References: <Pine.LNX.4.33L2.0211151658010.6746-100000@dragon.pdx.osdl.net>
From: Arun Sharma <arun.sharma@intel.com>
Date: 15 Nov 2002 17:46:21 -0800
In-Reply-To: <Pine.LNX.4.33L2.0211151658010.6746-100000@dragon.pdx.osdl.net>
Message-ID: <u65uyb82a.fsf@unix-os.sc.intel.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rddunlap@osdl.org ("Randy.Dunlap") writes:

> Look in arch/i386/kernel/setup.c (in 2.4.19):
> 
> There is this array:
>   struct resource standard_io_resources[] = ...
> that you could add to; you could even make the addition a CONFIG_ option.

That's reserving I/O ports. Are you suggesting that we create an
analogous array for IP ports ?

        -Arun

