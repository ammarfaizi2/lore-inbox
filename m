Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbUEFGqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUEFGqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 02:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUEFGqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 02:46:03 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:1920 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S261735AbUEFGp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 02:45:57 -0400
Date: Thu, 6 May 2004 08:45:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: shai@ftcon.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Multiple (ICH3) IDE-controllers in a system
Message-ID: <20040506064546.GA239@ucw.cz>
References: <200405042213.BLD39867@ms6.netsolmail.com> <200405051716.43909.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405051716.43909.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 05:16:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Vojtech,
> 
> Do I correctly assume that these fixups for Intel chipsets are from you?

Yes.

> http://linus.bkbits.net:8080/linux-2.5/cset@3cfbacdfzHvfqp0Sa45QXt9pNn3LNg?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/pci|related/arch/i386/pci/fixup.c
> http://linus.bkbits.net:8080/linux-2.5/cset@3cfcec0fOJreGFyCWkPeT7EWiydYFw?nav=index.html|src/|src/arch|src/arch/i386|src/arch/i386/pci|related/arch/i386/pci/fixup.c
> 
> Care to explain why 'trash' fixup is needed in 2.6 but not in 2.4?

Because 2.4 was never used on the affected machines, where this fixup
was needed - those machines sere putting nonsense into the BARs. I don't
recall exactly what model they were, though I remember they were one of
the first machines with ICH MMIO support.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
