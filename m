Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbUL2W2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUL2W2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 17:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUL2W2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 17:28:48 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:22437 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261269AbUL2W2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 17:28:45 -0500
Subject: Re: PATCH: 2.6.10 - IT8212 IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <58cb370e041229092919c1b4a8@mail.gmail.com>
References: <1104246926.22366.97.camel@localhost.localdomain>
	 <58cb370e041229092919c1b4a8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104355483.31622.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Dec 2004 21:24:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-29 at 17:29, Bartlomiej Zolnierkiewicz wrote:
> ide_get_best_pio_mode(drive, 4, 5, NULL) always returns 4
> [ quick fix == hardcode 4 for now and add FIXME ]

Doesn't seem that way reading the code.

I've folded the other changes (except moving the fixup) into my code
base and will give it a testing over the next few days and check for any
reversions.


