Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbUKUWom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUKUWom (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbUKUWom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:44:42 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10166 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261826AbUKUWol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:44:41 -0500
Date: Sun, 21 Nov 2004 23:44:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-os@analogic.com, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
In-Reply-To: <Pine.LNX.4.58.0411211433540.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.53.0411212343340.17752@yvahk01.tjqt.qr>
References: <20041120143755.E13550@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com>
 <Pine.LNX.4.58.0411211433540.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Actually, this is documented gcc behaviour,[...]
>you can do
>	int tickadj = *ptr++ ? : 1;
>and it's well-behaved in that it increments the pointer only once.

And it's specific to GCC. This kinda ruins some tries to get ICC working on the
kernel tree :)



Jan Engelhardt
-- 
