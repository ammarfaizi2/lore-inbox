Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317470AbSFDXZb>; Tue, 4 Jun 2002 19:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSFDXZa>; Tue, 4 Jun 2002 19:25:30 -0400
Received: from ns.suse.de ([213.95.15.193]:15375 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317470AbSFDXZ3>;
	Tue, 4 Jun 2002 19:25:29 -0400
Date: Wed, 5 Jun 2002 01:25:30 +0200
From: Dave Jones <davej@suse.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>, Brad Hards <bhards@bigpond.net.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386 "General Options" - begone [take 2]
Message-ID: <20020605012529.F4751@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	'Pavel Machek' <pavel@suse.cz>, Brad Hards <bhards@bigpond.net.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7ED9@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 04:09:48PM -0700, Grover, Andrew wrote:
 
 > > Can you confirm that you're not advocating a "ACPI or Legacy" 
 > > approach ?
 > > I think you're aware of the dragons that lie that way, but I 
 > > want to be sure my suspicions are unfounded.
 > All I can say is using just *part* of ACPI will cause some machine,
 > somewhere, to not work. I want to avoid scenarios where that happens. If
 > there are issues with that, can we discuss them asap, perhaps now?

Think vendor kernel. There we want to run on ancient pre-ACPI boxes,
and super duper new box with borken/non-existant legacy tables.
So just keep in mind that compiling both into the kernel is a must have
requirement.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
