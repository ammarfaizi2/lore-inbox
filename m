Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266633AbSLCXhS>; Tue, 3 Dec 2002 18:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbSLCXhR>; Tue, 3 Dec 2002 18:37:17 -0500
Received: from fmr01.intel.com ([192.55.52.18]:49369 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266633AbSLCXhR>;
	Tue, 3 Dec 2002 18:37:17 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A56D@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Arjan van de Ven'" <arjanv@redhat.com>, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: RE: [BK PATCH] ACPI updates
Date: Tue, 3 Dec 2002 15:29:56 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arjan van de Ven [mailto:arjanv@redhat.com] 
> > Is your concern with the code, or the cmdline option? We 
> could certainly
> 
> the code, not so much the commandline option (that one is not used
> in practice), but actually my biggest concern is that you 
> break existing
> setups, or at least change it more than needed. There is ZERO need to
> remove the existing working (and lean) code, even though your 
> code might
> also be able to do the same. It means people suddenly need to 
> change all
> kinds of config options, it's different code so will work slightly
> different... unifying 2.5 is nice and all but there's no need for that
> here since both implementations can coexist trivially (as the 
> United Linux
> kernel shows)

Well maybe that's what we should do - use the UnitedLinux ACPI patch (which
iirc is based on fairly recent ACPI code, and presumably minimizes
ACPI-related breakage) and then proceed incrementally from there?

Sound OK? Marcelo? UL folks?

Regards -- Andy

PS probably involve some work breaking out the ACPI stuff from the UL patch
as a whole, or maybe (???) the UL people already have it broken out?
