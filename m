Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277398AbRJZMgX>; Fri, 26 Oct 2001 08:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276330AbRJZMgN>; Fri, 26 Oct 2001 08:36:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:521 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276803AbRJZMgI>; Fri, 26 Oct 2001 08:36:08 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: helgehaf@idb.hist.no (Helge Hafting)
Date: Fri, 26 Oct 2001 13:38:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BD94A65.1A8E6B84@idb.hist.no> from "Helge Hafting" at Oct 26, 2001 01:35:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15x6FO-0008Ex-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Telling the kernel to suspend while burning a CD is
> on the same level as ejecting the CD while burning.  
> It has to go wrong.  Someone explicitly asking for
> trouble might as well get it.

It need not be someone asking for trouble. It might just be a ten minute
"nothing happened" timeout that starts the decision making.

> The really dumb users is probably using a GUI tool
> for either activity, that one may of course refuse
> to ruin the burn.

The current GUI tools don't know anything about 2.5 power management, and
in some cases don't know when the driver has done needed work or not.

Alan
