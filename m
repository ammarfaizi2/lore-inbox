Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSGFTzs>; Sat, 6 Jul 2002 15:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSGFTzr>; Sat, 6 Jul 2002 15:55:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36625 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315806AbSGFTzr>;
	Sat, 6 Jul 2002 15:55:47 -0400
Message-ID: <3D274D4F.8B232D76@zip.com.au>
Date: Sat, 06 Jul 2002 13:04:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inline generic_writepages(mapping,nr_to_write)?
References: <Pine.LNX.4.44.0207061104130.10105-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> 
> Hi,
> 
> (I keep forgetting whom to send mm suggestions, however this is a question
> for all of you.)
> 
> Now that generic_writepages() shrinked a lot, couldn't we consider making
> it inline?
> 
> inline int generic_writepages(struct address_space *mapping,
>                               int nr_to_write)
> {
>         return mpage_writepages(mapping, nr_to_write, NULL);
> }
> 

That would make sense.

-
