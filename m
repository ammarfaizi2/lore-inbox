Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292996AbSB1Ws3>; Thu, 28 Feb 2002 17:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310187AbSB1WpF>; Thu, 28 Feb 2002 17:45:05 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:35600 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S310197AbSB1WmS>; Thu, 28 Feb 2002 17:42:18 -0500
Message-ID: <3C7EB243.335B0328@linux-m68k.org>
Date: Thu, 28 Feb 2002 23:42:11 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch - sharing RTC timer between kernel and user space
In-Reply-To: <Pine.LNX.4.33.0202282155450.543-100000@pnote.perex-int.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jaroslav Kysela wrote:

> We need also a callback called at interrupt time.

Hmm, why don't you use a task queue for that?

bye, Roman
