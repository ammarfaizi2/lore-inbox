Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282948AbRL1PLx>; Fri, 28 Dec 2001 10:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286926AbRL1PLn>; Fri, 28 Dec 2001 10:11:43 -0500
Received: from maile.telia.com ([194.22.190.16]:33744 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S282948AbRL1PLb>;
	Fri, 28 Dec 2001 10:11:31 -0500
Date: Fri, 28 Dec 2001 16:16:08 +0100
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Sound fails to build when non-modular with new binutils
Message-ID: <20011228151608.GA1870@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

The new binutils in Debian uncovered a few bugs in the kernel, but I
have not yet seen anyone post a patch for the problem where building
sound with via82cxxx_audio set as non-modular fails with:

drivers/sound/sounddrivers.o(.data+0xb4): undefined reference to `local symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

Does anyone have a fix for this?
-- 

André Dahlqvist <andre.dahlqvist@telia.com>

