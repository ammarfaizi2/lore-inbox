Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUJBS05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUJBS05 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 14:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUJBS05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 14:26:57 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:48533 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267469AbUJBS0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 14:26:55 -0400
Subject: Re: 2.6.9-rc3 compile erros
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <415E6B74.5050100@eyal.emu.id.au>
References: <415E6B74.5050100@eyal.emu.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096737859.25312.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 02 Oct 2004 18:24:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-02 at 09:48, Eyal Lebedinsky wrote:
> I need DVB so I finaly made the move to 2.6[.9-rc3]. I get compile failures in two modules:
>      drivers/isdn/i4l/isdn_tty.c
>      drivers/net/wan/pc300_tty.c
> 
> Both look like careless typos - is 2,6 really stable by now?

Both already fixed and pushed upstream. The tty patch contained a couple
of typos in pieces I couldn't compile/test. (or in the case of ISDN
forgot to).

Should all be rippled out by rc4, and given the fact every serial driver
had to change I don't think it was too bad

