Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbUBWAHk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbUBWAHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:07:40 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:4100 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261240AbUBWAHi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:07:38 -0500
Message-Id: <200402202146.i1KLkdfu002972@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Anton Blanchard <anton@samba.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       paulmck@us.ibm.com, arjanv@redhat.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, torvalds@osdl.org
Subject: Re: Non-GPL export of invalidate_mmap_range 
In-Reply-To: Your message of "Fri, 20 Feb 2004 14:17:51 +1100."
             <20040220031751.GA20022@krispykreme> 
From: Valdis.Kletnieks@vt.edu
References: <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org> <20040218230055.A14889@infradead.org> <20040218153234.3956af3a.akpm@osdl.org> <20040219123237.B22406@infradead.org> <20040219105608.30d2c51e.akpm@osdl.org> <20040219190141.A26888@infradead.org>
            <20040220031751.GA20022@krispykreme>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2136242002P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Feb 2004 16:46:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2136242002P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 Feb 2004 14:17:51 +1100, Anton Blanchard <anton@samba.org>  said:
>  
> > You've probably not seen the AIX VM architecture.  Good for you as it's
> > not good for your stomache.  I did when I still was SCAldera and although
> > my NDAs don't allow me to go into details I can tell you that the AIX
> > VM architecture is deeply tied into the segment architecture of the Power
> > CPU and signicicantly different from any other UNIX variant.
> 
> Interesting, what version of AIX did you get access to? And how can you
> be sure thats still the case?

You don't need access to AIX source.  Reading the IBM Redbook on writing a
device driver for AIX is sufficient proof. Or even reading up on how to get
more heap space than the usual number of segment registers using the 'ld'
command (yes, it's userspace visible).

And Christoph isn't pulling your leg -  it's pretty bizzare...


--==_Exmh_-2136242002P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFANoA/cC3lWbTT17ARAoA/AKCdBGBaBLuAG17SxD65Wy8oLSRXwACg10eB
j+L2bUYIGht679TIpX2GytM=
=4KoB
-----END PGP SIGNATURE-----

--==_Exmh_-2136242002P--
