Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUBHNz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 08:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUBHNz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 08:55:59 -0500
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:2486 "EHLO
	nx5.hrz.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263618AbUBHNz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 08:55:58 -0500
Date: Sun, 8 Feb 2004 14:54:46 +0100 (CET)
From: Ingo Buescher <usenet-2004@r-arcology.de>
X-X-Sender: gallatin@nathan.cybernetics.com
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI and APM together?
In-Reply-To: <402623F2.2020604@web.de>
Message-ID: <Pine.LNX.4.58.0402081450480.10706@anguna.ploreargvpf.pbz>
References: <402623F2.2020604@web.de>
X-Binford: 6100 (more power)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Feb 2004, Todor Todorov wrote:

> Hello list,
>
> definitely needs APM. So the question is, if it would be possible to
> compile both ACPI and APM into the kernel and pass the corsponding
> parameters acpi=off or apm=off where it is appropriate? I looked through

> Todor

It is possible - I have used this for quite some time now.

/boot/grub/menu.lst:

title Linux 2.6 - test (ACPI on)
root (hd0,4)
kernel (hd0,4)/vmlinuz.26-test hdc=ide-cd  video=rivafb:800x600-8@85
acpi=on apm=off

title Linux 2.6 - test (APM on)
root (hd0,4)
kernel (hd0,4)/vmlinuz.26-test hdc=ide-cd  video=rivafb:800x600-8@85
acpi=off apm=on


Ingo
-- 
===========================================================================
Ingo Buescher <gallatin@gmx.net>
"No one who's seen it in action can say the phrase 'government help'
without either laughing or crying." -- unknown
