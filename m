Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290607AbSBLACV>; Mon, 11 Feb 2002 19:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290609AbSBLACK>; Mon, 11 Feb 2002 19:02:10 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:43274 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290607AbSBLABy>; Mon, 11 Feb 2002 19:01:54 -0500
Message-ID: <3C685B6E.59076E64@linux-m68k.org>
Date: Tue, 12 Feb 2002 01:01:50 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: thread_info implementation
In-Reply-To: <3C6832CC.D9D27F2F@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote:

> 1. I more liked the previous byte fields instead of the bitmasks.
> bitfield/bitmask instructions are at least 2 bytes longer than a simple
> test instruction for m68k.

Additional note: The currently used bitfield instruction can be quite
expensive, where all we need is an atomic read and write, but not an
atomic test/modify.

bye, Roman
