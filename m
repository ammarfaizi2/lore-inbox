Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbRFQR7R>; Sun, 17 Jun 2001 13:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbRFQR7H>; Sun, 17 Jun 2001 13:59:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61200 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262600AbRFQR6z>; Sun, 17 Jun 2001 13:58:55 -0400
Subject: Re: a memory-related problem?
To: rbultje@ronald.bitfreak.net (Ronald Bultje)
Date: Sun, 17 Jun 2001 18:57:48 +0100 (BST)
Cc: klink@clouddancer.com, linux-kernel@vger.kernel.org
In-Reply-To: <992806021.2007.0.camel@tux.bitfreak.net> from "Ronald Bultje" at Jun 17, 2001 09:26:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Bgo0-0002q1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just noticed this: if I supply "linux-2.4.4 mem=255M" instead of
> "linux-2.4.4 mem=256M" at the lilo prompt, it does work. Is this a bug
> in the code that handles options given at startup-time? (I only tried
> this for 2x128 sticks but I suppose this is the same for 2x64+1x128
> sticks - I guess I'm too lazy to try it out).

Its common for the BIOS to reserve and use the top 1K or so
