Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbTDXKFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 06:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTDXKFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 06:05:08 -0400
Received: from [195.95.38.160] ([195.95.38.160]:40438 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262711AbTDXKFH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 06:05:07 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Russell King <rmk@arm.linux.org.uk>, devilkin-lkml@blindguardian.org
Subject: Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Date: Thu, 24 Apr 2003 12:13:16 +0200
User-Agent: KMail/1.5.1
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200304230747.27579.devilkin-lkml@blindguardian.org> <20030424085756.A9597@flint.arm.linux.org.uk> <200304241206.43717.devilkin-lkml@blindguardian.org>
In-Reply-To: <200304241206.43717.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304241213.21939.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 24 April 2003 12:06, DevilKin wrote:
> Uh... The Maestro3 is integrated on the motherboard, so that's kinda hard.
>
> I have 1 pcmcia card and 1 cardbus card in the system (see below).
> I have tested the booting with no cards, than it boots fine. Booting with
> only the pcmcia card also works fine, so It's really the cardbus card that
> seems to throw the system into an unstable state.
>

Forgot to mention that inserting the cardbus card afterwards and modprobe'ing 
the module then (3c59x) works ok too. Its only during the detection that 
something seems to go wrong.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+p7i+puyeqyCEh60RAvpqAJ4nT5C26gAzEKmp18wqArh7cIjf4gCeP116
mir+3C9x7idsfJpnbDdrDpI=
=5vOg
-----END PGP SIGNATURE-----

