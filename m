Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315048AbSENCHe>; Mon, 13 May 2002 22:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315050AbSENCHd>; Mon, 13 May 2002 22:07:33 -0400
Received: from fmr01.intel.com ([192.55.52.18]:57303 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S315048AbSENCHb>;
	Mon, 13 May 2002 22:07:31 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7E45@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Patrick Mochel (mochel@osdl.org)" <mochel@osdl.org>,
        "Jeff Garzik (jgarzik@mandrakesoft.com)" <jgarzik@mandrakesoft.com>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'Greg@kroah.com'" <Greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: pci segments/domains
Date: Mon, 13 May 2002 19:07:23 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, ACPI calls them "segments" but a previous discussion (c.f. "RFC:
Changes for PCI" from a year ago) called them domains.

I don't care what they're called, but I wanted to bring them up and see what
everyone thought about how best to implement them, or at least if anyone had
an objection to adding a "segment" parameter to pci_scan_root.

I certainly don't have a machine that uses these but some people do, and it
sounds like it would be nice to handle them in an arch-neutral way.

Regards -- Andy

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

