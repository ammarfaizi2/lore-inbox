Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267907AbTBLWqZ>; Wed, 12 Feb 2003 17:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267913AbTBLWqZ>; Wed, 12 Feb 2003 17:46:25 -0500
Received: from [213.171.53.133] ([213.171.53.133]:51984 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S267907AbTBLWqY>;
	Wed, 12 Feb 2003 17:46:24 -0500
Date: Thu, 13 Feb 2003 01:55:58 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Andreas Arens <ari@goron.de>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] AMD IDE oops in current 2.4-ac
In-Reply-To: <20030212194912.GA24138@codemonkey.org.uk>
Message-ID: <Pine.BSF.4.05.10302130143420.43443-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003, Dave Jones wrote:

> On Wed, Feb 12, 2003 at 08:48:15PM +0100, Andreas Arens wrote:
>  > Current 2.4.21-pre4-ac kernels oops in amd74xx.c with
>  > certain chipsets due to a table order problem. The
>  > problem is correctly detected by a BUG() in the pci probe
>  > routine, which should trigger for all non-nforce chipsets.
> 
> If moving entries in the table caused a bug, adding new entries
> could do the same too perhaps ? This sounds quite fragile
> based on your description & diff.
> 
> 		Dave
	Hello, Dave and other.
Same behavior was in 2.5.5x and I've send similar patch to Linus and it
was apllied. Changeset 1.879.1.84. There is two tables and missorder of
devices cause a BUG() during init.
	Thanks, Ruslan.

