Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285936AbRLVAfr>; Fri, 21 Dec 2001 19:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285705AbRLVAfi>; Fri, 21 Dec 2001 19:35:38 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:60136 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S285936AbRLVAfS>; Fri, 21 Dec 2001 19:35:18 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D819@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Hans-Christian Armingeon'" <linux.johnny@gmx.net>,
        linux-kernel@vger.kernel.org
Subject: RE: link errors with CONFIG_SERIAL_ACPI enabled
Date: Fri, 21 Dec 2001 16:35:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SERIAL_ACPI should be an IA64 only option (but it's not) so just
deselect it for now if you're on IA32.

Regards -- Andy

> From: Hans-Christian Armingeon [mailto:linux.johnny@gmx.net]
> Am Freitag, 21. Dezember 2001 22:45 schrieb Hans-Christian Armingeon:
> > Hi folks,
> > I noticed, that every time I switch on CONFIG_SERIAL_ACPI 
> as a Module, I
> > get some linker errors when make bzImage tries to link the bzImage
> > together. I don't have the exact output at hands, but I'll 
> reproduce it if
> > needed.
> here it comes
