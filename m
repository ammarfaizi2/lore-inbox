Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVJ2Q2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVJ2Q2i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 12:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVJ2Q2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 12:28:38 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:34056 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1751215AbVJ2Q2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 12:28:37 -0400
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       333776@bugs.debian.org
Subject: Re: Bug#333776: linux-2.6: vfat driver in 2.6.12 is not properly case-insensitive
References: <20051013165529.GA2472@tennyson.dodds.net>
	<20051028082252.GC11045@verge.net.au>
	<874q71wv2b.fsf@devron.myhome.or.jp>
	<200510291645.08872.ioe-lkml@rameria.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 30 Oct 2005 01:28:11 +0900
In-Reply-To: <200510291645.08872.ioe-lkml@rameria.de> (Ingo Oeser's message of "Sat, 29 Oct 2005 16:45:02 +0200")
Message-ID: <87k6fwcmp0.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> writes:

>> This is known bug. For fixing this bug cleanly, we will need to much
>> change the both of nls and filesystems.
>
> Using per locale collation sequences? :-)
>
> Do you know, how Windows handles the problem of differing collation 
> sequences on the file system?

I don't know. Why do we need to care the collation sequences here?

> Or is the file system always dependend on the locale of the Windows
> version, which created the file system?

Probably, yes. I think we need to know on-disk filename's code set.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
