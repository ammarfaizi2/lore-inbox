Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276377AbRJGOMb>; Sun, 7 Oct 2001 10:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276380AbRJGOML>; Sun, 7 Oct 2001 10:12:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42245 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276377AbRJGOMI>; Sun, 7 Oct 2001 10:12:08 -0400
Subject: Re: Linux should not set the "PnP OS" boot flag
To: jdthood@mail.com (Thomas Hood)
Date: Sun, 7 Oct 2001 15:18:00 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1002462656.831.112.camel@thanatos> from "Thomas Hood" at Oct 07, 2001 09:50:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qEkj-0005uw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes (if you mean: clears the "Booting" flag).  This is a different
> flag from the PnP-OS flag.  The PnP-OS flag is bit 0; the "Booting"
> flag is bit 1.  So this is a separate issue.

Its very much the same issue. Only a marked successful PnP boot counts
for anything

> But look at the code (following).  The code DOES NOT clear the "Booting"
> flag.  It ONLY sets the PnP-OS flag.  Not only that: when it does so
> it fails to change bit 7 in order to preserve odd parity, as the spec
> requires.

sbf_write computes parity
