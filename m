Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275320AbTHGNHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275314AbTHGNHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:07:40 -0400
Received: from main.gmane.org ([80.91.224.249]:49584 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S275320AbTHGNHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:07:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Loading Pentium III microcode under Linux - catch 22!
Date: Thu, 07 Aug 2003 15:04:28 +0200
Message-ID: <yw1xn0elty8z.fsf@users.sourceforge.net>
References: <20030807122850.99548.qmail@web40611.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:13wcYJBMtCXvqoCCmTv0is5LA5I=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Rankin <rankincj@yahoo.com> writes:

> I have an i840 motherboard with a pair of 933 MHz PIII
> Coppermine CPUs, and I use your microcode driver to
> load the latest Intel microcode into my CPUs. This is
> very important because these CPUs are buggy without
> their microcode, and I would prefer to have the BIOS
> load it except that this would prevent me from booting
> into memtest. I have tried this before - memtest
> crashes with an "Unexpected Interrupt" error after a
> few minutes. (No i840 workarounds enabled?) Since I
> suspect that DOS would do the same thing and I would
> boot into DOS to flash firmware, I have decided that
> crashes like this would be a Bad Thing.

If the microcode in the CPUs is buggy, they are faulty and you should
demand to get them replaced at no cost.

> In an ideal world, I would like Linux to load the
> microcode *before* the kernel boots, which begs the
> question of "How?". Can you suggest anything, please?
> I remember talk of boot-time RAM disks, and wondered
> if the microcode could be placed on one of these
> somehow? Or would that be ruled out immediately by the
> microcode's non-GPL nature?

I guess it would be possible to compile the microcode into the kernel
and have some code in arch/i386/* load it as early as possible.  As
long as you don't distribute the compiled kernel you should be fine
wrt licensing.

-- 
Måns Rullgård
mru@users.sf.net

