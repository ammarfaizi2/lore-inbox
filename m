Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVAPKlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVAPKlx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 05:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVAPKlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 05:41:53 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:30475 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262473AbVAPKlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 05:41:51 -0500
Date: Sun, 16 Jan 2005 11:50:11 +0100
To: Dave Airlie <airlied@gmail.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@gmail.com>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Message-ID: <20050116105011.GA5882@hh.idb.hist.no>
References: <41E64DAB.1010808@hist.no> <16870.21720.866418.326325@ccs.covici.com> <21d7e997050113130659da39c9@mail.gmail.com> <20050115185712.GA17372@hh.idb.hist.no> <21d7e997050116020859687c4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21d7e997050116020859687c4a@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 09:08:38PM +1100, Dave Airlie wrote:

> Well the problem with a lot of ATI chips is they can be put onto
> either an AGP or PCI card and work fine, so chips which are AGP chips
> can end up on PCI cards...
> 
X uses chip ID to guess wether it is an AGP or PCI card?  Ouch.
Doesn�'t the kernel know very well how the card is connected,
couldn't X get this from the same interfaces "lspci" uses?

> it sounds like something may have broken the int10 stuff, but I've no
> idea what, the only other thing I can think to recommend doing is an
> binary search say starting at 2.6.9-rc1 and maybe using the -bk
> snapshots to nail down exactly when it went wrong....

That�'s an option.  It'll take time though, it is a multiuser machin; 
I can compile all the kernels I want but rebooting isn't
that popular.

Helge Hafting
