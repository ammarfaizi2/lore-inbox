Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbTBYTFL>; Tue, 25 Feb 2003 14:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbTBYTFK>; Tue, 25 Feb 2003 14:05:10 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:53777 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267121AbTBYTFJ>; Tue, 25 Feb 2003 14:05:09 -0500
Date: Tue, 25 Feb 2003 20:14:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: atomic_t (24 bits???)
In-Reply-To: <Pine.LNX.3.95.1030225140554.20186A-100000@chaos>
Message-ID: <Pine.LNX.4.44.0302252014340.32518-100000@serv>
References: <Pine.LNX.3.95.1030225140554.20186A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 25 Feb 2003, Richard B. Johnson wrote:

> In ../linux/include/asm/atomic.h, for versions 2.4.18 and
> above as far as I've checked, there are repeated warnings
> "Note that the guaranteed useful range of an atomic_t is
> only 24 bits."
> 
> I fail to see any reason why as atomic_t is typdefed to a
> volatile int which, on ix86 seems to be 32 bits.
> 
> Does anybody know if this is just some old comments from a
> previous atomic_t type of, perhaps, char[3]?  

include/asm-sparc/atomic.h

bye, Roman

