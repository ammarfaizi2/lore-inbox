Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSFDVUH>; Tue, 4 Jun 2002 17:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSFDVUG>; Tue, 4 Jun 2002 17:20:06 -0400
Received: from ns.suse.de ([213.95.15.193]:29452 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316825AbSFDVUD>;
	Tue, 4 Jun 2002 17:20:03 -0400
Date: Tue, 4 Jun 2002 23:20:03 +0200
From: Dave Jones <davej@suse.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>, Brad Hards <bhards@bigpond.net.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@rustcorp.com.au
Subject: Re: [patch] i386 "General Options" - begone [take 2]
Message-ID: <20020604232003.Y4751@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	'Pavel Machek' <pavel@suse.cz>, Brad Hards <bhards@bigpond.net.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	trivial@rustcorp.com.au
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7ED5@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 01:59:11PM -0700, Grover, Andrew wrote:

 > This is a tough one because ACPI *is* power management but it is also
 > configuration. It is equivalent to such things as MPS table parsing, $PIR
 > parsing, PNPBIOS, as well as APM. The first two don't have CONFIG_ options
 > at the moment but they should at some point.
 > The only thing I can think of is a "Platform interface options" menu and
 > just throw all of the above in that. Any other ideas?

You seem to be halfway down the road of splitting ACPI in two already,
with the introduction of CONFIG_ACPI_HT_ONLY recently. Why not bundle
such options under a CONFIG_ACPI_INITIALISATION or the likes, and
put the rest under the power management menu as Brad suggested ?

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
