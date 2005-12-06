Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVLFNsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVLFNsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVLFNsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:48:43 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:46608 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S932555AbVLFNsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:48:42 -0500
Date: Tue, 6 Dec 2005 13:48:03 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Jean Delvare <khali@linux-fr.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Questions on __initdata
Message-ID: <20051206134803.GA19629@linux-mips.org>
References: <20051204151533.13df37c6.khali@linux-fr.org> <200512041741.43591.arnd@arndb.de> <20051205203730.GA2753@linux-mips.org> <200512061432.12693.pluto@agmk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200512061432.12693.pluto@agmk.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 02:32:12PM +0100, Paweł Sikora wrote:

> Dnia poniedziałek, 5 grudnia 2005 21:37, Ralf Baechle napisał:
> 
> > blurb.c: At top level:
> > blurb.c:3: error: somevariable causes a section type conflict
> 
> This was a gcc bug. The current gcc mainline works fine.

That was gcc 3.4 which it this time is probably the most common compiler.
It'll be a while until it'll have been phased out - and const __initdata
isn't exactly a must-have construct anyway.

  Ralf
