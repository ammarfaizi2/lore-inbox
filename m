Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130294AbRBZOen>; Mon, 26 Feb 2001 09:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130261AbRBZOb2>; Mon, 26 Feb 2001 09:31:28 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130282AbRBZO3w>;
	Mon, 26 Feb 2001 09:29:52 -0500
Subject: Re: 2.2.18: static rtc_lock in nvram.c
To: Ulrich.Windl@rz.uni-regensburg.de (Ulrich Windl)
Date: Mon, 26 Feb 2001 09:33:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A9A0AF9.17727.45317@localhost> from "Ulrich Windl" at Feb 26, 2001 07:51:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XK2K-0000sY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> browsing the sources for some problem I wondered why nvram.c uses a 
> static spinlock named rtc_lock, hiding the global one.

It only does that for the atari, where the driver isnt used by other things


