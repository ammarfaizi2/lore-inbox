Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUBKNtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 08:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbUBKNtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 08:49:04 -0500
Received: from gaia.cela.pl ([213.134.162.11]:24337 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264365AbUBKNtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 08:49:03 -0500
Date: Wed, 11 Feb 2004 14:48:54 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: wdebruij@dds.nl
Cc: sting sting <zstingx@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: printk and long long 
In-Reply-To: <1076506513.402a2f9120fb8@webmail.dds.nl>
Message-ID: <Pine.LNX.4.44.0402111448320.10791-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> how about simply using a shift to output two regular longs, i.e.
> 
> printk("%ld%ld",loff_t >> (sizeof(long) * 8), loff_t << sizeof(long) * 8 >>
> sizeof(long) * 8);

I'd venture to guess you'd also have to cast the above to long.

Cheers,
MaZe.

