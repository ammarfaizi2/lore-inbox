Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264729AbUFGMmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264729AbUFGMmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUFGMjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:39:18 -0400
Received: from gprs214-225.eurotel.cz ([160.218.214.225]:48768 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264649AbUFGMiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 08:38:51 -0400
Date: Mon, 7 Jun 2004 14:38:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Kloska <kloska@scienion.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
Message-ID: <20040607123839.GC11860@elf.ucw.cz>
References: <40C0E91D.9070900@scienion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C0E91D.9070900@scienion.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My impression is that APM is slowly degenerating while ACPI is not
> (yet ?) able to fill the gap. The suspend feature of ACPI is stated to
> be dangerous and experimental and does not work for me at all.

That sounds about right.

> After all this bashing...
> 
> Is there anyone out there who has the same experiences ?
> 
> Is there a workaround ?
> 
> Is it possible to somehow downgrade APM in the 2.6 kernel
> to the 2.4.x state ?
> 
> How could one debug this kind of missbehaviour ? Where do
> I have to look for potential miss configurations of the system ?
> 
> I'm really willing  to help the APM developers to track down this bug
> but don't have a clue how to debug this kind stuff.

What APM developers? There are none as far as I know.

Try removing calls to device_* in apm.c. Better yet become APM
developer.

							Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
