Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWFQJZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWFQJZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 05:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWFQJZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 05:25:59 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:52188 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750915AbWFQJZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 05:25:58 -0400
Date: Sat, 17 Jun 2006 11:25:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: daniel+devel.linux.lkml@flexserv.de, linux-kernel@vger.kernel.org
Subject: Re: Bug: XFS internal error XFS_WANT_CORRUPTED_RETURN
In-Reply-To: <Pine.LNX.4.64.0606161811280.10656@p34.internal.lan>
Message-ID: <Pine.LNX.4.61.0606171119350.15799@yvahk01.tjqt.qr>
References: <878xnx19bs.fsf@xserver.flexserv.de> <200606161835.26428.s0348365@sms.ed.ac.uk>
 <87irn0zsqq.fsf@xserver.flexserv.de> <Pine.LNX.4.61.0606170005150.27136@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0606161811280.10656@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about:
>
> SunVTS software
>
Requires Solaris, which I presume those who run linux on it, have removed 
it :)

> The SunVTS software executes multiple diagnostic hardware tests from a
> single user interface, and is used to verify the configuration and
> functionality of most hardware controllers and devices. The SunVTS software
> operates primarily from a graphical user interface, enabling test parameters
                            ^^^^^^^^^
> to be set quickly and easily while a diagnostic test operation is being
> performed.
>
> http://docs.sun.com/source/817-7665/pmemtest.html
>
> The pmemtest checks the physical memory of the system and reports hard and
> soft error correction code (ECC) errors, memory read errors, and addressing
> problems. The pseudo driver mem is used to read the physical memory.
                                             ^^^^

Does not sound very promising :(


Jan Engelhardt
-- 
