Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTKAJns (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 04:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTKAJns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 04:43:48 -0500
Received: from gaia.cela.pl ([213.134.162.11]:3846 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263734AbTKAJnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 04:43:47 -0500
Date: Sat, 1 Nov 2003 10:43:42 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Anthony DiSante <orders@nodivisions.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Audio skips when RAM is ~full
In-Reply-To: <3FA353E4.60906@nodivisions.com>
Message-ID: <Pine.LNX.4.44.0311011042440.23028-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I'm guessing that there isn't actually a way to manually move buffer-data 
> out of RAM?

Just the naive allocate X MB, set the first byte of every 4KB (PageSize) 
block to 1 and then free the memory - presto X MB free RAM.

Cheers,
MaZe.


