Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVAJCQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVAJCQV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 21:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVAJCQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 21:16:20 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:26001 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S262051AbVAJCQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 21:16:18 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: shawvrana@acm.org, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org, plazmcman@softhome.net
Subject: Re: Screwy clock after apm suspend
References: <7bb8b8de05010710085ea81da9@mail.gmail.com>
	<20050109224711.GF1353@elf.ucw.cz>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Sun, 09 Jan 2005 18:15:36 -0800
In-Reply-To: <20050109224711.GF1353@elf.ucw.cz> (message from Pavel Machek
 on Sun, 9 Jan 2005 23:47:11 +0100)
Message-ID: <877jmm2fnb.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> Just thought I'd add that I too am seeing a big time drift on my
>> Thinkpad (T30) without ACPI during an APM suspend w/ 2.6.10.  If I can
>> help by testing patches, or providing any additional information,
>> please let me know.
>
> Probably code to compensate clock after ACPI suspend breaks apm case
> :-(.

i see problems with the clock after doing an acpi suspend. the
hardware clock is more or less okay (within a few minutes of the real
time anyway, nothing that ntp can't take care of) but the system time
is way off. this first started happening with 2.6.10-rc1. by now i've
gotten into the habit of running 'hwclock -s' by hand after each
resume. not really sure what changed and what i can do to debug/fix
this. for all it's worth i am running debian unstable.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
