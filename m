Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbQJ1KDg>; Sat, 28 Oct 2000 06:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129288AbQJ1KDZ>; Sat, 28 Oct 2000 06:03:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:265 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129239AbQJ1KDT>; Sat, 28 Oct 2000 06:03:19 -0400
Subject: Re: [PATCH] Make agpsupport work with modversions
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 28 Oct 2000 11:02:04 +0100 (BST)
Cc: dwmw2@infradead.org (David Woodhouse), vojtech@suse.cz (Vojtech Pavlik),
        alan@redhat.com (Alan Cox), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org
In-Reply-To: <5122.972699496@ocs3.ocs-net> from "Keith Owens" at Oct 28, 2000 01:18:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pSoP-0005Et-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> of get_module_symbol this weekend.  The inter-object registration code
> will allow two objects to pass data to each other, it will not matter
> whether the objects are both modules, one module and one built in (in
> either order) or both built in.  When modules are involved there will
> be full module locking.

Dont forget that one of the objects may not even be present, or may be
loaded later.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
