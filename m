Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129513AbRAaXGW>; Wed, 31 Jan 2001 18:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129530AbRAaXGM>; Wed, 31 Jan 2001 18:06:12 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:6670 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129513AbRAaXGC>; Wed, 31 Jan 2001 18:06:02 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE61F@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'drew@drewb.com'" <drew@drewb.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: RE: ACPI fix + comments
Date: Wed, 31 Jan 2001 15:05:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Drew Bertola [mailto:drew@drewb.com]
> > This is a temporary interface, just to see if we're returning values
> > properly. Your points below are well taken. People really care about
> > minutes/percentage remaining. In your opinion should we 
> just report that
> > through /proc or should we keep the data low-level like it 
> is now, and have
> > a user app do the math, or what?
> 
> I'd be happy with the way it is now if I could understand the data.
> Is there any documentation available to help me convert it?

Well the ACPI spec (http://www.teleport.com/~acpi/spec.htm) talks about the
returned values, and I'm guessing the calculation is just (x capacity (mAh)
/ y draw (mA) = time left).

But like I said this interface is a placeholder.

-- Andy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
