Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130441AbRCIHYf>; Fri, 9 Mar 2001 02:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbRCIHYY>; Fri, 9 Mar 2001 02:24:24 -0500
Received: from [213.95.12.190] ([213.95.12.190]:38660 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S130441AbRCIHYP> convert rfc822-to-8bit;
	Fri, 9 Mar 2001 02:24:15 -0500
From: "Daniela Engert" <dani@ngrt.de>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 09 Mar 2001 08:25:43 +0100 (CET)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.00
In-Reply-To: <20010308195107.A8509@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: Linux 2.4.2ac12 (vt82c686 info)
Message-Id: <20010309072110.DB1C73E75@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001 19:51:07 +0100, Vojtech Pavlik wrote:

>They're about the same - only Alan didn't like the PCI speed measurement
>code that's new in the 4.x series, so I added all the other changes to
>the 3.20 driver, and 3.21 was born.

I do understand Alan's objections against this speed measurement code
very well. I have similar code built into other (non-Linux) drivers,
and according to the many user reports that I got the measurement
results should be taken with a grain of salt. It is working perfectly
in most cases, but it may fail from time to time. There is a hidden
assumption in this type of measurement which the device that you run
the test against has to fulfill. If it doesn't (and it is not required
to do to be conforming to the ATA spec), the measurement results (PCI
bus clock) are bogus (typically way too high).

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


