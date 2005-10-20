Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbVJTHoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbVJTHoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 03:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbVJTHoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 03:44:10 -0400
Received: from exchange-cpt.prism.co.za ([196.25.143.130]:9425 "EHLO
	prism.co.za") by vger.kernel.org with ESMTP id S1751781AbVJTHoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 03:44:08 -0400
Date: Thu, 20 Oct 2005 09:41:29 +0200
From: Bernd Jendrissek <berndj@prism.co.za>
To: Andrew Hendry <ahendry@tusc.com.au>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       eis@baty.hanse.de, linux-x25@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] X25: Add ITU-T facilites
Message-ID: <20051020074129.GA13695@prism.co.za>
References: <1129513666.3747.50.camel@localhost.localdomain> <20051017022826.GA23167@mandriva.com> <1129615767.3695.15.camel@localhost.localdomain> <20051018.152318.68554424.yoshfuji@linux-ipv6.org> <20051018153702.GC23167@mandriva.com> <Pine.LNX.4.61.0510181144320.28065@chaos.analogic.com> <1129770654.3574.1154.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129770654.3574.1154.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Comment: Exim: I am on zebra.wetton.prism.co.za (internal name)
X-Comment: and my boss is berndj@prism.co.za
X-Comment: Call him at +27 82 2960717 if any problems occur.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, Oct 20, 2005 at 11:10:54AM +1000, Andrew Hendry wrote:
> __u32 or unsigned int look to be the norm for other similar headers,
> whats the recommended type of types to be used?

Dunno if this helps, but AFAIK the C language (as of 1999 or is it 2000)
blesses uint32_t and friends.

Indeed, <linux/types.h> (in the kernel source tree) defines these
*standard* sized types.

HTH

- -- 
A PC without Windows is like ice cream without ketchup.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Please fetch my new key 804177F8 from hkp://wwwkeys.eu.pgp.net/

iD8DBQFDV0ohwyMv24BBd/gRAnOAAKCpTJLsIIQCGW4X/KMyoIMwZ0TNewCff2vE
IO7gmOpr1zuFa515lmIPWno=
=uytG
-----END PGP SIGNATURE-----
