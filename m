Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSFQKd2>; Mon, 17 Jun 2002 06:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316891AbSFQKd2>; Mon, 17 Jun 2002 06:33:28 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26642 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316887AbSFQKd1>; Mon, 17 Jun 2002 06:33:27 -0400
Message-ID: <3D0DBAEE.2030409@evision-ventures.com>
Date: Mon, 17 Jun 2002 12:33:18 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/19] writeback tunables
References: <3D0D86D7.644F0C13@zip.com.au>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> + * The interval between `kupdate'-style writebacks.
> + */
> +int dirty_writeback_centisecs = 5 * 100;
> +
> +/*
> + * The largest amount of time for which data is allowed to remain dirty
> + */
> +int dirty_expire_centisecs = 30 * 100;
> +

Blind guess - didn't the 100 wan't to be HZ?!

