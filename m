Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSLZFzJ>; Thu, 26 Dec 2002 00:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSLZFzJ>; Thu, 26 Dec 2002 00:55:09 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:14458 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S262414AbSLZFzI> convert rfc822-to-8bit; Thu, 26 Dec 2002 00:55:08 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Josh Brooks'" <user@mail.econolodgetulsa.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: CPU failures ... or something else ?
Date: Thu, 26 Dec 2002 00:03:17 -0600
Message-ID: <001b01c2aca4$7f69a840$b9293a41@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20021225175232.O6873-100000@mail.econolodgetulsa.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> localhost kernel: Kernel panic: CPU context corrupt

What that basically means is that given some values A, B, and C, in the
context of those values the kernel expects X, Y, and Z to be of some other
value, but X, Y, and Z aren't turning out to be expected.

> Word on the street is that this indicates
> hardware failure of some kind
> [trimmed]
> is that very surely the culprit, or is it
> also possible that all of the hardware is
> perfect and that a bug in the kernel code
> or some outside influence (remote exploit)
> is causing this crash ?

Hardware failures of any kind are relatively rare, rarest of all is a CPU
failure (unless you buy from TC Computers which sold me TWO defective
CPU's).

In your quest to place blame, I'd start with:
1) outdated kernel - you never did say your kernel version
2) other third party processes, especially modules.

> whatever that thing is where you press
> ctrl-alt-printscreen and get to enter
> those post-crash commands - do you think
> that would work in this situation, or does
> the above error hard lock the system so
> you can't do those emergency measures ?

You're thinking of when X (the graphical user interface) crashes.  X is
sufficiently abstracted from the kernel so that if it crashes, the rest of
the computer doesn't come down with it.  When the KERNEL crashes (a.k.a.
"kernel panic"), it crashes HARD.  This is the equivalent of the Blue Screen
of the Death(tm) from which the only "recovery" is the reboot button.

Joseph Wagner

