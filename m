Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbTAVTqt>; Wed, 22 Jan 2003 14:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTAVTqt>; Wed, 22 Jan 2003 14:46:49 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:4874 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262472AbTAVTqs>; Wed, 22 Jan 2003 14:46:48 -0500
Message-ID: <3E2EE21C.D44EFF9F@linux-m68k.org>
Date: Wed, 22 Jan 2003 19:25:32 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Olaf Dietsche <olaf.dietsche@t-online.de>
CC: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] restore modules compatibility
References: <Pine.LNX.4.44.0301211749390.5658-100000@spit.local>
		<87el76avlf.fsf@goat.bogus.local> <3E2E0874.1B95BA77@linux-m68k.org> <87y95da819.fsf@goat.bogus.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Olaf Dietsche wrote:

> When the associated variables are declared after the MODULE_PARM(),
> you get this error. There may be more of this kind.
> 
> I fixed this by moving the declarations, see patch below.

Thanks for testing, there are indeed more places which would need
fixing. I did a larger compile check and got 173 errors in 57 files, but
it's trivial to fix, so it would be worth it.

bye, Roman


