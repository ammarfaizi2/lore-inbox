Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTLVXCd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264556AbTLVXCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:02:33 -0500
Received: from hell.org.pl ([212.244.218.42]:9489 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264553AbTLVXCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:02:32 -0500
Date: Tue, 23 Dec 2003 00:02:37 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org
Cc: pZa1x <pZa1x@rogers.com>
Subject: Re: 2.6.0 release + ALSA + suspend = not work
Message-ID: <20031222230237.GA26609@hell.org.pl>
References: <15Ee5-Id-5@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <15Ee5-Id-5@gated-at.bofh.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote pZa1x:
> ALSA stops producing sound after any time I suspend my Thinkpad T20 
> notebook. I am using 2.6.0 release and the snd-cs46xx driver.
> 
> I have to log out of Gnome and remove the sound card module and re 
> modprobe it then restart Gnome to get sound back.
> 
> No problems with 2.4.20 with OSS drivers.

I have a similar problem here (ICH3M, CS4299, snd-intel8x0). In my case,
using OSS emulation in userspace and ALSA modules in kernel works fine, so
it must be a locking problem of some kind, anyway probably something
trivial to fix.
A similar problem occurs under 2.4, FYI.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
