Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289011AbSAZDp1>; Fri, 25 Jan 2002 22:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSAZDpU>; Fri, 25 Jan 2002 22:45:20 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:42114 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S289011AbSAZDpM>; Fri, 25 Jan 2002 22:45:12 -0500
Date: Sat, 26 Jan 2002 03:37:03 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Patrick Mochel <mochel@osdl.org>, Grover Andrew <andrew.grover@intel.com>,
        "'lwn@lwn.net'" <lwn@lwn.net>,
        "\"Acpi-linux (E-mail)\"" <acpi-devel@lists.sourceforge.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: ACPI mentioned on lwn.net/kernel
Message-ID: <20020126033703.E5730@kushida.apsleyroad.org>
In-Reply-To: <Pine.LNX.4.33.0201251019230.800-100000@segfault.osdlab.org> <E16UBRa-0003IA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16UBRa-0003IA-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 25, 2002 at 06:51:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > (*) Aside from any potential copyright infringement on the tables 
> > themselves. But, it is theoretically possible to override the DSDT with 
> 
> Criminal liability under the DMCA and five years in jail too, along with
> having your SF account pulled and losing your ISP access at the first
> suggestion of copyright issues - and since you posted that email you are
> clearly not doing so by accident.

Fortunately he was citing a legitimate purpose: to workaround ACPI table
bugs.  Perhaps some judges favour legitimacy while other ones favour
corruption; choose your judges wisely :-)

> Its *no* different. In fact since AML can be used to hit chipset ports to
> trap into SMM mode its identical

Except that because we can change the tables, or detect certain access
sequences, we have the possibility to _not_ hit the chipset ports to
trap into SMM mode.  It's much harder to do this with BIOS routines (but
not impossible, just harder).

Until they reduce all the AML to single port accesses which do nothing
except call SMM mode.  That takes us right back to the APM problems ;-)

-- Jamie
