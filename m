Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSLCSbw>; Tue, 3 Dec 2002 13:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSLCSbw>; Tue, 3 Dec 2002 13:31:52 -0500
Received: from fmr02.intel.com ([192.55.52.25]:34502 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265085AbSLCSbv>; Tue, 3 Dec 2002 13:31:51 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A56B@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Arjan van de Ven'" <arjanv@redhat.com>, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: RE: [BK PATCH] ACPI updates
Date: Tue, 3 Dec 2002 10:39:18 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arjan van de Ven [mailto:arjanv@redhat.com] 
> Marcelo,
> 
> Please don't merge this. This patch removes existing, small, working,
> maintained functionality from the kernel and "replaces" it with
> something else for which patches aren't even accepted and 
> that is a lot
> bigger and less readable code.
> 
> Not only is it rude on the side of the ACPI people to remove 
> "competing"
> functionality, but it will break all kinds of existing setups that now
> have to change the way they configure their system. In 
> addition it's not
> even needed, the existing code can live together with the code Andrew
> proposes just fine as the United Linux kernel proves.

The ACPI code's CPU-enumeration-only config option does what acpitable.[ch]
did. This has been in 2.5 for a long time, so this would unify the 2.4 and
2.5 approaches.

Is your concern with the code, or the cmdline option? We could certainly
keep the same cmdline option "acpismp=force" if that is the issue, but that
always seemed like kind of a strange name for the option, to me.

Regards -- Andy
