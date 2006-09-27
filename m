Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWI0Lmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWI0Lmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWI0Lmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:42:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63420 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030188AbWI0Lmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:42:54 -0400
Subject: Re: Asus A7V133: IRQ6: nobody cared!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609271215.32875.prakash@punnoor.de>
References: <200609271215.32875.prakash@punnoor.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Sep 2006 13:07:48 +0100
Message-Id: <1159358869.11049.337.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-27 am 12:15 +0200, ysgrifennodd Prakash Punnoor:
> So my question, even if this is due to a broken bios, should a quirk be 
> inserted into linux to not allow to assign IRQ6 to a PCI device? I guess this 
> should prevent the issue.

Not really. PC platforms without old style floppies, or when old style
floppies are disabled can correctly assign IRQ 6 to PCI devices. This
includes VIA systems, providing the floppy is disabled/off correctly.

Alan

