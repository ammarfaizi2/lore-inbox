Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUGIPvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUGIPvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 11:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265001AbUGIPvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 11:51:25 -0400
Received: from motgate2.mot.com ([144.189.100.101]:20955 "EHLO
	motgate2.mot.com") by vger.kernel.org with ESMTP id S264997AbUGIPvX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 11:51:23 -0400
In-Reply-To: <40EDE70C.40202@246tNt.com>
References: <40ED7C51.90103@246tNt.com> <17F799EA-D13C-11D8-A787-000393DBC2E8@freescale.com> <40EDE70C.40202@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D3F66906-D1BF-11D8-B72C-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Kumar Gala <kumar.gala@motorola.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 1/2] Freescale MPC52xx support for 2.6 - Base part
Date: Fri, 9 Jul 2004 10:51:23 -0500
To: Sylvain Munaut <tnt@246tnt.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 8, 2004, at 7:30 PM, Sylvain Munaut wrote:

> Kumar Gala wrote:
>
> > A few comments:
> >
> > cputable.c: * the 8280/52xx, maybe we should just have G2_LE, (same
> > core exists in 8272, 8249, etc.)
>
> IMHO, yes it may be better.

> > mpc52xx_setup.c: * what is cpu_52xx[]?
>
> A table with coefficients taken from datasheet. They're used to
> compute the core frequency according to XLB bus frequency and external
> jumper configurations.

Mind adding the above as a comment in the code.  :)

> > ppcboot.h: * was bi_immr_base not sufficient?
>
> I suppose your question is why create bi_mbar_base instead of using 
> immr.
> Well, I guess that would work just fine. The structure is just taken 
> straight from U-Boot sources.

Yes that was what I was asking about, and fair enough if we are 
mirroring the u-boot structure.  One of these days we will clean all of 
that up.

- kumar

