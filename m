Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbTLMUYb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 15:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbTLMUYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 15:24:31 -0500
Received: from gaia.cela.pl ([213.134.162.11]:4109 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S265293AbTLMUYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 15:24:30 -0500
Date: Sat, 13 Dec 2003 21:23:55 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
       <linux-kernel@vger.kernel.org>
Subject: Re: FAT fs sanity check patch
In-Reply-To: <87fzfofsks.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.44.0312132122020.6211-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bad hack? Why? Do you know how mount operation is dangerous and it's
> difficult for fatfs? Do you want to handle the any format as FAT?
> 
> This is completely unrelated to handling the cache.

How about not playing around with fat detection and instead implement a 
force mount flag for FAT, which would ignore all (most?) detection errors.  
Of course if errors occured later you'd end up with a R/O filesystem.  And if 
you forced something that wasn't FAT, you'd be screwed... but that's to be 
expected...

Cheers,
MaZe.


