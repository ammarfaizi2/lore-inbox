Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265654AbSKAIKq>; Fri, 1 Nov 2002 03:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265655AbSKAIKq>; Fri, 1 Nov 2002 03:10:46 -0500
Received: from vsmtp2.tin.it ([212.216.176.222]:61379 "EHLO smtp2.cp.tin.it")
	by vger.kernel.org with ESMTP id <S265654AbSKAIKq>;
	Fri, 1 Nov 2002 03:10:46 -0500
Message-ID: <3DC23869.486C6258@denise.shiny.it>
Date: Fri, 01 Nov 2002 09:16:41 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.19 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx and error recovery
References: <3DC1B03C.7FDB86E3@denise.shiny.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:
>
> [...] It happens that when a recoverable error occurs (as
> reported in the sys logs) read()(2) returns a value smaller then
> requested, and the loaded data is identical to the pattern, or
> read() completes, but the data is wrong.

Ehm, I made a stupid typo in my test program. read() does dot
succeed in the second case. Anyway the problem is still here:
why does it fail on recovered errors ?


Bye.
