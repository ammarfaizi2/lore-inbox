Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbTAKOus>; Sat, 11 Jan 2003 09:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbTAKOus>; Sat, 11 Jan 2003 09:50:48 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:22277 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267243AbTAKOur>; Sat, 11 Jan 2003 09:50:47 -0500
Message-ID: <3E202F43.E51FB502@linux-m68k.org>
Date: Sat, 11 Jan 2003 15:50:43 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Brodowski <linux@brodo.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: menucofig[2.5.56] bug: help texts in "choice"
References: <20030110220402.GA1909@brodo.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dominik Brodowski wrote:

> In 2.5.56 I'm seeing a bug in "make menuconfig" on x86: selecting "processor
> type and features", then "processor family", and then "help" for any entry,
> I always get "There is no help available for this kernel option." even
> though there are extensive help texts in arch/i386/Kconfig.

Move the help text from CONFIG_M386 entry to the choice entry. I didn't
do this automatically since often the help text has to splitted
manually. It's on my TODO list, but I still hope someone else would like
to do this. :)
BTW menuconfig will only show the general help text. Showing the
individual help text entries would require changing lxdialog, what I
tried to avoid so far (so it's even lower on my TODO list).

bye, Roman

