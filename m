Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbUBKP6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 10:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbUBKP6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 10:58:23 -0500
Received: from gaia.cela.pl ([213.134.162.11]:25860 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S265504AbUBKP6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 10:58:22 -0500
Date: Wed, 11 Feb 2004 16:58:13 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: wdebruij@dds.nl, sting sting <zstingx@hotmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: printk and long long
In-Reply-To: <200402111604.49082.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0402111655170.17933-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004, vda wrote:

> The character L specifying that a following e, E, f, g, or G
> conversion corresponds to a long double argument, or a following
> d, i, o, u, x, or X conversion corresponds to a long long argument.
> Note that long long is not specified in ANSI C and therefore
> not portable to all architectures.

[ personally I'd say screw the un-portable architectures ;) ]
Long long is here to stay.
Besides if a linux architecture utilises long long in the kernel and 
doesn't support it in printf via %lld then it's horked.
printf/libc should be fixed instead.
Maybe that's the problem - the libc support fragment in the kernel tree is 
not up to date on that architecture - maybe the fixes should applied there 
instead - instead of trying to work around the problem, fix the cause.

Cheers,
MaZe.

