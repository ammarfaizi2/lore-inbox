Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbUKQKiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUKQKiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUKQKfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:35:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:23723 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262263AbUKQKer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:34:47 -0500
Date: Wed, 17 Nov 2004 11:34:46 +0100 (MET)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: miller@techsource.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Intel Corp. 82801BA/BAM not supported by ALSA?
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <25978.1100687686@www46.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy,

Perhaps check that your BIOS hasn't disabled it, or anything isn't disabling
it at boot time with 'setpci ... command=0'.

---

When I do 'lspci | grep -i audio', I get this:

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 
Audio (rev 04)

Unfortunately, every effort has failed to get the slightest peep out.  I 
have tried following the instructions on the Gentoo site (with my own 
guesses about what to do differently for 2.6 kernels), but I don't get 
any sound.  Also, the "alsaconf" utility says it doesn't find any audio 
devices.

Can anyone help me with this?

-- 
Daniel J Blueman

Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
