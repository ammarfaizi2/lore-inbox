Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265315AbRFWAbO>; Fri, 22 Jun 2001 20:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264680AbRFWAbE>; Fri, 22 Jun 2001 20:31:04 -0400
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:45511 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265315AbRFWAap>; Fri, 22 Jun 2001 20:30:45 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDEEF@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, proski@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: RE: ACPI + Promise IDE = disk corruption :-(((
Date: Fri, 22 Jun 2001 17:30:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> I've seen several people report ACPI eats disks. ACPI is 
> incredibly complex
> badly designed crud. My advice is never use ACPI. This 
> incidentally appears
> to be the advice Microsoft give people too - they tell people 
> to disable
> ACPI as one of the first steps to diagnosing strange crashes 
> in machines

They're just bugs. That's why it's marked experimental, and unlike the rest
of the "experimental" drivers, we aren't kidding.

It's just *one* issue that has generated all the disk corruption reports.
Putting the processor into the C3 power state, in combination with bus
mastering. This is disabled in the most recent release. I'd love to fix this
one, but if it were easy, it'd be fixed by now. Maybe you can shed some
light - if you're willing, let me know and I'll describe the problem in
greater detail.

> I've been discussing with a few folk about doing an 
> alternative mini acpi
> subset so that Linux can be booted on most 'ACPI only' 
> hardware without 
> using all the ACPI junk

Could these discussions be opened up to a wider readership? Perhaps you
could use linux-pm-devel@sourceforge.net, or
acpi@phobos.fachschaften.tu-muenchen.de?

Regards -- Andy

