Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263304AbUFSANr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUFSANr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbUFSANo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:13:44 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:2572 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S265422AbUFSANG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 20:13:06 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <debian-legal@lists.debian.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: How long is it acceptable to leave *undistributable* files in the kernel package?
Date: Fri, 18 Jun 2004 17:12:58 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEINMLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <40D2F463.6090104@almg.gov.br>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2120
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 18 Jun 2004 16:50:42 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 18 Jun 2004 16:50:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But wait; firmware is *not* linking with the kernel, as the icons
> are *not* linking with emacs.  Or are they? What is linking? If you
> consider linking to give names fixups and resolving them, well, the
> char tg3_fw[] = ... is linked with the kernel all right. If you
> consider that a call (as in the asm CALL opcode sense) must be made,
> it's not. The firmware does not "execute", at least in the main CPU.
> Anyway, the non-GPL-compatibly-licensed icon in your previous emacs
> example is *most* *certainly* not linking with emacs (in the
> ld-or-ld.so sense) and it's OK.
>
> The (simplified) answer: the GPL "do not link" is weak because of
> the "mere aggregation clause" and because of the dichotomy between
> derivative and anthology works; it's weaker in the case of the
> binary kernel modules, especially if they are not distributed with
> the kernel (the linking is done at the end user, where many things
> are possible); it's even weaker in the case of firmware (because
> firmware does not /properly/ link in the software sense, even if it
> *does* link in the ld-or-ld.so sense); it's really faint in the case
> of an accompanying icon or image (or movie: eMovix comes to mind).

	I think there's a continuum here. If, for example, the firmware in the
Linux kernel is identical to the firmware in the Windows driver and the
Linux kernel contains no special code to talk to this firmware (in other
words, the firmware makes this device look like every other similar device
and the kernel contains a generic driver), then the 'mere aggregation'
argument is persuasive. We have two independently derived works that happen
to be combined in a single file. They each happen to implement the same
interface from opposite sides, but they do so for different reasons and are
not specifically designed to work as a unit.

	On the flip side, if the Linux kernel code were developed just to talk to
this firmware and this firmware were developed just to make this device work
with Linux, then the 'mere aggregation' argument seems ludicrous. Each work
is specifically designed to work with the other, they aren't just combined
after the fact. The two had to have been developed together and each has
portions that only make sense in combination with the other.

	There are, of course, points in the middle of the continuum.

	I personally have no issues with the lack of the preferred form for the
purposes of making modifications. I don't find that fight worth fighting in
any case. I do, however, have major issues with use restrictions and
distribution restrictions. Code that cannot be freely used, reverse
engineered, modified, used on whatever hardware or with whatever software,
or distributed subject only to the GPL restrictions should not be integrated
into the Linux kernel. These restrictions cut to the heart of the very
freedoms the GPL is supposed to protect.

	DS

	PS: Please CC me on any replies that you wish me to read and possibly reply
to.


