Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262573AbTCISx6>; Sun, 9 Mar 2003 13:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262574AbTCISx6>; Sun, 9 Mar 2003 13:53:58 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3588 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262573AbTCISx4>;
	Sun, 9 Mar 2003 13:53:56 -0500
Date: Fri, 7 Mar 2003 23:26:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Eric Altendorf <EricAltendorf@orst.edu>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.63: ACPI S3 and S4 suspend problems
Message-ID: <20030307222610.GA164@elf.ucw.cz>
References: <200303061148.15685.EricAltendorf@orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303061148.15685.EricAltendorf@orst.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi all, running a Libretto L2 (ACPI only) on which I've been trying to 
> get suspend working for ages.  My latest try was 2.5.63 with the 
> 20030228 ACPI update patch.
> 
> S3 powers down into sleep mode, and upon awakening, prints
>         Linux!
> in yellow text and hangs.

This is hard to debug... S4 should be easier.

> S4 starts putting processes in the refrigerator, and hangs on the last 
> line (which just says "=|" IIRC).

Can you report exact messages/trace hang with printk?

> Any ideas?  I can supply system info and kernel config info if 
> helpful.

Yep, user printk() to locate where it hangs ;-). Then fix it. Then
submit a patch.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
