Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281124AbRKUJOM>; Wed, 21 Nov 2001 04:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281568AbRKUJOC>; Wed, 21 Nov 2001 04:14:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63756 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281690AbRKUJNu>; Wed, 21 Nov 2001 04:13:50 -0500
Subject: Re: New ac patch???
To: marcel@mesa.nl
Date: Wed, 21 Nov 2001 09:21:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk), linux-kernel@vger.kernel.org
In-Reply-To: <20011121100849.D15851@joshua.mesa.nl> from "Marcel J.E. Mol" at Nov 21, 2001 10:08:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E166TZh-0004T8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.13-ac will "flushing ide drives" on shutdown. This helped my laptop
> from not '/dev/hdax no cleanly unmounted, checking' on startup. I'm sure
> the system did not crash before that.

You have a box with an IBM 20Gig 2.5" drive (just out of interest)

> 2.4.15-pre6 does not have this code and now sometimes some filesystems
> seem not to be clean anymore on startup...
> Will the ide_notify_reboot be included in 2.4.15 final?

Probably not - the taskfile/LBA48 code wants more testing first. I believe
you can pick up the relevant patch from www.linux-ide.org however, thanks
to Andre
