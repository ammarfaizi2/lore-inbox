Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265559AbRGEXJB>; Thu, 5 Jul 2001 19:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265537AbRGEXIw>; Thu, 5 Jul 2001 19:08:52 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:9973 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S265534AbRGEXIf>; Thu, 5 Jul 2001 19:08:35 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDF38@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Petr Vandrovec'" <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: What are rules for acpi_ex_enter_interpreter?
Date: Thu, 5 Jul 2001 16:05:43 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report on the locking issue. A fix is checked in locally.

> From: Petr Vandrovec [mailto:vandrove@vc.cvut.cz]
> Replying to myself, after following change in additon to acpi_ex_...
> poweroff on my machine works. It should probably map type 0 
> => 0, 3 => 1
> and 7 => 2, but it is hard to decide without VIA datasheet, so change
> below is minimal change needed to get poweroff through ACPI 
> to work on my 
> ASUS A7V.

How did you discover slp typ values of 2 worked, where 7 did not? Did you
just try all possibilities (0-7)?

Regards -- Andy

