Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSK0MYr>; Wed, 27 Nov 2002 07:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSK0MYq>; Wed, 27 Nov 2002 07:24:46 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:64404 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262430AbSK0MYq>; Wed, 27 Nov 2002 07:24:46 -0500
Subject: Re: 2.5.49 module problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Young-Ho Cha <ganadist@nakyup.mizi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021127043532.GA25666@nakyup.mizi.com>
References: <20021126193026.Q14666-100000@sorrow.ashke.com>
	<1038362008.2594.112.camel@irongate.swansea.linux.org.uk> 
	<20021127043532.GA25666@nakyup.mizi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 13:03:26 +0000
Message-Id: <1038402206.6394.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-27 at 04:35, Young-Ho Cha wrote:
> I use rusty's module init tools with modutils 2.4.22.
> 
> But many modules cannot load.
> 
> attach some list of modules that kernel cannot load.

Rusty's code has a design flaw and demands a "no_modules_init" clause.
When this is fixed in the kernel tree/tools the problem will go away.
Since the problem is clearly a modules one I don't plan to fix the -ac
drivers.

