Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOFFw>; Wed, 15 Nov 2000 00:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKOFFo>; Wed, 15 Nov 2000 00:05:44 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:28689 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129045AbQKOFF0>; Wed, 15 Nov 2000 00:05:26 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200011150435.UAA05562@cx518206-b.irvn1.occa.home.com>
Subject: [BUG?] AMD K5 and 2.4 (was Re: Updated 2.4 TODO List)
To: linux-kernel@vger.kernel.org
Date: Tue, 14 Nov 2000 20:35:31 -0800 (PST)
Reply-To: barryn@pobox.com
In-Reply-To: <200010112210.e9BMAe002775@trampoline.thunk.org> from "tytso@mit.edu" at Oct 11, 2000 06:10:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm replying to a message from about a month ago, but it's relevant to a
problem I'm having now.)

tytso@mit.edu wrote:

>    Date: Mon, 09 Oct 2000 20:13:35 +0200
>    From: Thomas Sailer <sailer@ife.ee.ethz.ch>
> 
[snip]
>    My Asus P55TP4 (i430FX)/AMD K5 PC also crashes after "Booting the
>    kernel..."
>    and before printing anything else
> 
> Are you sure it was compiled with the correct CPU?  If you configure the
> CPU incorrectly (686 when you only have a 586, etc.) the kernel *will*
> refuse to boot.

I have a Compaq Presario 425 here, with a K5 upgrade (by Evergreen
Technologies) in it. It reboots immediately after "Booting the kernel..."
with Linux 2.4.0test10 (I haven't tried test11preX on this machine) if the
kernel is compiled for 586/K5/etc. If I compile for 486, then it boots. If
I compile for 586/K5/etc. with 2.2.17, it boots. (This is all with egcs
1.1.2.)

Is this a real bug or just a documentation bug?

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
