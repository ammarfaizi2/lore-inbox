Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSLPNmH>; Mon, 16 Dec 2002 08:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSLPNmH>; Mon, 16 Dec 2002 08:42:07 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:21446 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262418AbSLPNmG>; Mon, 16 Dec 2002 08:42:06 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Linux v2.5.52
Date: 16 Dec 2002 14:53:58 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87r8cixe6h.fsf@bytesex.org>
References: <Pine.LNX.4.44.0212151930120.12906-100000@penguin.transmeta.com>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Trace: bytesex.org 1040046839 9263 127.0.0.1 (16 Dec 2002 13:53:59 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> XFS, JFS, ACPI and USB updates. KConfig update, and Rusty's module
> parameter implementation. And fix the stupid nanosleep() thing that broke 
> some programs.

Something broke the init= kernel cmd line option, I suspect Rusty's
parameter stuff ...

I boot my box via initrd + pivot_root, with "ramdisk_size=16384
root=/dev/ram0 init=/linuxrc rw" on the kernel command line.  When
booting 2.5.52 I get a shell prompt at the point where usually linxrc
starts.  Just typing "exec /linuxrc" at this point invokes the usual
boot sequence ...

  Gerd

-- 
Weil die späten Diskussionen nicht mal mehr den Rotwein lohnen.
				-- Wacholder in "Melanie"
