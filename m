Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTFKN4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 09:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTFKN4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 09:56:31 -0400
Received: from gw.netgem.com ([195.68.2.34]:41999 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id S261872AbTFKN4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 09:56:30 -0400
Subject: Re: init does not run on 405GP system
From: Jocelyn Mayer <jma@netgem.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: robert@schwebel.de
Content-Type: text/plain
Organization: 
Message-Id: <1055340746.4967.339.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Jun 2003 16:12:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Jun 11, 2003 at 09:53:04AM +0300, Denis Vlasenko wrote: 
> > I once tried to run 686 based libc on a 486, init was rained upon
> > by SIGILLs 'coz it had 586+ instructions. No output on the screen
> > whatsoever.
> 
> 
> I've tried it with the DENX busybox rootimage which is definitely
> tested 
> extensively on PPC4xx, but it does not work. 
> 
> 
> Robert 
> 
Hi,

You may have wrong compilation options.
Please send me your test program and I'll test it on a PPC403 board.
>From my tests, it seems that gcc 3.xx specs are quite buggy for those
embedded processors and need to be patched to produce correct code.

Regards.

-- 
Jocelyn Mayer <jma@netgem.com>

