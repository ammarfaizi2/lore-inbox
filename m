Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270125AbRHGHeh>; Tue, 7 Aug 2001 03:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270124AbRHGHe1>; Tue, 7 Aug 2001 03:34:27 -0400
Received: from clavin.efn.org ([206.163.176.10]:29643 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S270123AbRHGHeM>;
	Tue, 7 Aug 2001 03:34:12 -0400
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15215.39409.12204.662831@localhost.efn.org>
Date: Tue, 7 Aug 2001 00:34:08 -0700
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <200108070420.f774KXl04696@www.2ka.mipt.ru>
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de>
	<Pine.LNX.4.33.0108062047310.17919-100000@kobayashi.soze.net>
	<15215.27296.959612.765065@localhost.efn.org>
	<200108070420.f774KXl04696@www.2ka.mipt.ru>
X-Mailer: VM 6.95 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Polyakov writes:
 > Hmmm, if you have PHYSICAL access to the machine, you can simply reboot and type 
 > "linux init=/bin/sh" and after it simply cat /etc/shadow and run John The Ripper....
 > Am i wrong?

You can password-protect LILO to prevent others from giving it their own
boot options.  Similarly you can password-protect single-user mode so
either a deliberate shutdown-and-reboot to single-user mode, or an
attempt to induce the machine to go into single-user mode, will prevent
others from getting at the single-user root shell.

