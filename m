Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRC0WQR>; Tue, 27 Mar 2001 17:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRC0WQI>; Tue, 27 Mar 2001 17:16:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61445 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131669AbRC0WP5>; Tue, 27 Mar 2001 17:15:57 -0500
Subject: Re: Larger dev_t
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 27 Mar 2001 23:16:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@transmeta.com (H. Peter Anvin),
        Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <Pine.LNX.4.31.0103271333160.25014-100000@penguin.transmeta.com> from "Linus Torvalds" at Mar 27, 2001 01:35:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14i1ln-0004Tn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> high-end-disks. Rather the reverse. I'm advocating the SCSI layer not
> hogging a major number, but letting low-level drivers get at _their_
> requests directly.

A major for 'disk' generically makes total sense. Classing raid controllers
as 'scsi' isnt neccessarily accurate. A major for 'serial ports' would also
solve a lot of misery

