Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbSLFB2b>; Thu, 5 Dec 2002 20:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbSLFB2b>; Thu, 5 Dec 2002 20:28:31 -0500
Received: from fmr01.intel.com ([192.55.52.18]:742 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267496AbSLFB2a>;
	Thu, 5 Dec 2002 20:28:30 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@ucw.cz>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
Subject: RE: [BK PATCH] ACPI updates
Date: Thu, 5 Dec 2002 17:36:02 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@ucw.cz] 

I (Andy) said:
> > Well maybe that's what we should do - use the UnitedLinux 
> ACPI patch (which
> > iirc is based on fairly recent ACPI code, and presumably minimizes
> > ACPI-related breakage) and then proceed incrementally from there?
> > 
> > Sound OK? Marcelo? UL folks?

> I guess it will be better if you push acpi patch without killing those
> backup solutions. Extractign blacklist from UL might be worth it,
> through.

Well after communicating with Marcelo it sounds like he'd like to hold off
taking it in 2.4.21 because IDE changes take priority, and two big changes
at once is too many for a stable kernel revision.

Fair enough. I'm just worried that 2.4.22 is a long ways away.

Maybe one way to address Marcelo's stability concerns and Arjan's "keep
acpitable.[ch] around" preference is for me to submit a patch that I *know*
don't affect anything besides ACPI -- i.e. only the changes that have been
made under drivers/acpi, and then go from there, submitting UL-derived and
other improvements incrementally after that.

Thoughts?

Regards -- Andy
