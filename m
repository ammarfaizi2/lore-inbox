Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289110AbSAVAqk>; Mon, 21 Jan 2002 19:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289114AbSAVAqa>; Mon, 21 Jan 2002 19:46:30 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:29455 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289110AbSAVAqP>; Mon, 21 Jan 2002 19:46:15 -0500
Message-ID: <3C4CB631.354D206D@linux-m68k.org>
Date: Tue, 22 Jan 2002 01:45:37 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Robert Love <rml@tech9.net>, Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <1011647882.8596.466.camel@phantasy> <20020121144937.A18422@hq.fsmlabs.com> <1011650506.850.483.camel@phantasy> <20020121165659.A20501@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> I have not seen that argued - certainly I have not argued it myself.
> My argument is:

Which is your usual FUD and everything was discussed before, just
repeating claims without any arguments doesn't make it better. :-(

>         It makes the kernel _much_ more complex

It certainly adds complexity, but which new feature doesn't?
Please specify "_much_ more complex".

>         It has known costs e.g. by making the lockless
>                 per-processor caching  more difficult if not impossible

It would only expose the locking, which is currently hidden in the smp
infrastructure.
What's so "impossible" about it?

>         It seems to lead to a requirement for inheritance

Where? I still haven't seen any proof for this.

>         It has no demonstrated benefits.

http://kpreempt.sourceforge.net/benno/linux+kp-2.4.6/3x256.html

bye, Roman
