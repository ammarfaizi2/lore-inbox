Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLMCib>; Tue, 12 Dec 2000 21:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbQLMCiV>; Tue, 12 Dec 2000 21:38:21 -0500
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:26639 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id <S129267AbQLMCiM>; Tue, 12 Dec 2000 21:38:12 -0500
To: " Paul C. Nendick " <pnendick@highku.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.16 SMP: mtrr errors
In-Reply-To: <3A3693A8.E0BA83B7@home.com> <E145wtZ-0001pn-00@the-village.bc.nu>
        <20001211155822.A1901@thefunk.org>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 13 Dec 2000 02:07:44 +0000
Message-ID: <y7rzoi16plb.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

" Paul C. Nendick " <pnendick@highku.com> writes:
> Shall I submit this to Matrox as a bug then?

The "bug" is in the XFree86 core, so telling Matrox might not do a lot
of good.

The driver code just says "I want to map a framebuffer of this size at
this physical address" (or actually "with these PCI details"), and the
core code arranges the mapping, doing the MTRR stuff while it's at it.

David Wragg

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
