Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbUAZVnW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUAZVnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:43:22 -0500
Received: from palrel10.hp.com ([156.153.255.245]:55938 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265465AbUAZVm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:42:59 -0500
Date: Mon, 26 Jan 2004 13:42:57 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: bunk@fs.tum.de, marcelo.tosatti@cyclades.com,
       irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] fix via-ircc.c .text.exit error
Message-ID: <20040126214257.GB17646@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040125004030.GE6441@fs.tum.de> <20040126192836.GA17134@bougret.hpl.hp.com> <20040126210126.GG513@fs.tum.de> <20040126.130242.74547942.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126.130242.74547942.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 01:02:42PM -0800, David S. Miller wrote:
>    From: Adrian Bunk <bunk@fs.tum.de>
>    Date: Mon, 26 Jan 2004 22:01:26 +0100
> 
>    On Mon, Jan 26, 2004 at 11:28:36AM -0800, Jean Tourrilhes wrote:
>    > 	Thanks you Adrian. Yes, I must confess that I never test
>    > non-modular build (because it doesn't work).
>    
>    Are you saying it might compile statically, but it won't work?
>    
> It won't link because many IRDA drivers erroneously don't
> mark their module_{init,exit}() routines static, thus
> symbols conflict.
> 
> I'm fixing that now.

	I was talking with Adrian about 2.4.X where things are quite
different with respect to driver initialisation.

	Jean
