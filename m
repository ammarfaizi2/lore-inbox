Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSKRNYc>; Mon, 18 Nov 2002 08:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbSKRNYc>; Mon, 18 Nov 2002 08:24:32 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:10500 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id <S261859AbSKRNYb>;
	Mon, 18 Nov 2002 08:24:31 -0500
Date: Mon, 18 Nov 2002 07:23:57 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.48 Compilation Failure skbuff.c
In-Reply-To: <20021118101230.N1407@almesberger.net>
Message-ID: <Pine.LNX.4.44.0211180719510.12736-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Werner Almesberger wrote:

> Rene Blokland wrote:
> > include/linux/crypto.h: In function `crypto_tfm_alg_modname':
> > include/linux/crypto.h:202: dereferencing pointer to incomplete type
> [...]
> > Any comments?
> 
> Disabling modules should work around this. Alternatively, you can
> try the untested patch below. I also had to disable devfs to build
> 2.4.58.

Disabling modules didn't work.  I also received the same error, built both 
modular and monolithic.  James Morris submitted an alternate patch I'll 
try when I get off work, pending further comments.  


