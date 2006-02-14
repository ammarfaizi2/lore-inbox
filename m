Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422721AbWBNRuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422721AbWBNRuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWBNRuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:50:24 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29836 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422714AbWBNRuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:50:23 -0500
Subject: Re: [PATCH] ide: Allow IDE interface to specify its not capable of
	32-bit operations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Kumar Gala <galak@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0602140900n4558d608p36e73a58c132b8ac@mail.gmail.com>
References: <Pine.LNX.4.44.0602141022000.27351-100000@gate.crashing.org>
	 <1139935828.10394.44.camel@localhost.localdomain>
	 <58cb370e0602140900n4558d608p36e73a58c132b8ac@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 17:53:25 +0000
Message-Id: <1139939605.11979.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-14 at 18:00 +0100, Bartlomiej Zolnierkiewicz wrote:
> > Do a grep over the code for no_io_32bit and you will see its essentially
> > a private variable in the CMD640 driver.
> 
> Please grep ide.c for "no_io_32bit".  Thank you.

Ok I take it back its merely broken and pointless code rather than do
nothing.

Alan

