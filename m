Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSFEK3l>; Wed, 5 Jun 2002 06:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSFEK3k>; Wed, 5 Jun 2002 06:29:40 -0400
Received: from ns.suse.de ([213.95.15.193]:531 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S314459AbSFEK3j>;
	Wed, 5 Jun 2002 06:29:39 -0400
Date: Wed, 5 Jun 2002 12:29:39 +0200
From: Dave Jones <davej@suse.de>
To: Brad Hards <bhards@bigpond.net.au>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@rustcorp.com.au
Subject: Re: [patch] i386 "General Options" - begone [take 2]
Message-ID: <20020605122939.H5277@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Brad Hards <bhards@bigpond.net.au>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	'Pavel Machek' <pavel@suse.cz>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	trivial@rustcorp.com.au
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7ED5@orsmsx111.jf.intel.com> <200206051134.24063.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 11:34:23AM +1000, Brad Hards wrote:

 > One idea that comes to mind is putting the power management config options in 
 > a "Power Management" section

*nod* sounds sensible 8)
 
 > then PNPBIOS in with the other PnP stuff, and 
 > so on (read: don't know were to put MPS yet, and don't know what $PIR is :)

It's an interrupt routing table.

MPS and interrupt routing are both CPU related features, so the best
place we currently have is under the CPU menu imho.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
