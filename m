Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbQKGAbg>; Mon, 6 Nov 2000 19:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130328AbQKGAb0>; Mon, 6 Nov 2000 19:31:26 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:4107 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129792AbQKGAbL>;
	Mon, 6 Nov 2000 19:31:11 -0500
Date: Mon, 6 Nov 2000 16:31:54 -0800
From: David Hinds <dhinds@valinux.com>
To: David Ford <david@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: current snapshots of pcmcia
Message-ID: <20001106163154.A20457@valinux.com>
In-Reply-To: <3A06757F.3C63F1A8@linux.com> <20001106104927.A19573@valinux.com> <3A073C8D.B6511746@linux.com> <20001106154039.A19860@valinux.com> <3A074AAC.1F88DB3@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <3A074AAC.1F88DB3@linux.com>; from David Ford on Mon, Nov 06, 2000 at 04:19:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Incidentally, the i82365 module should work ok (using ISA interrupts)
despite the "No IRQ known" messages.  The Yenta driver won't work at
all if PCI interrupts aren't set up.  So I guess another question
would be, what card(s) are you using and how are they misbehaving?

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
