Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129377AbRBLBP4>; Sun, 11 Feb 2001 20:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130924AbRBLBPq>; Sun, 11 Feb 2001 20:15:46 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:56117 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S129377AbRBLBPe>;
	Sun, 11 Feb 2001 20:15:34 -0500
Message-ID: <20010212021532.A28317@win.tue.nl>
Date: Mon, 12 Feb 2001 02:15:32 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Jan Niehusmann <jan@gondor.com>, linux-kernel@vger.kernel.org
Subject: Re: /dev/rtc not working on ASUS A7V133
In-Reply-To: <20010212012755.A656@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010212012755.A656@gondor.com>; from Jan Niehusmann on Mon, Feb 12, 2001 at 01:27:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 01:27:55AM +0100, Jan Niehusmann wrote:

> If my ASUS A7V133-based computer got started by the bios automatic
> startup timer, /dev/rtc doesn't work properly. /proc/drivers/rtc
> shows sane values, but IRQ 8 is not triggered causing programms like
> 'hwclock' to hang.
> 
> I assume this is not a kernel bug but a BIOS problem, but it would be
> nice if a kernel workaround was possible. Does anybody have an 
> idea what I could try to reenable the interrupts?

I suppose you could give hwclock --directisa ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
