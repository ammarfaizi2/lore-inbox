Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285136AbRLRUen>; Tue, 18 Dec 2001 15:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285132AbRLRUef>; Tue, 18 Dec 2001 15:34:35 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:23225 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S284958AbRLRUe3>; Tue, 18 Dec 2001 15:34:29 -0500
Date: Tue, 18 Dec 2001 21:33:27 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: nicoya@apia.dhs.org, ian@ichilton.co.uk, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc1 wont do nfs root on Javastation
In-Reply-To: <20011218.113725.82100134.davem@redhat.com>
Message-ID: <Pine.GSO.3.96.1011218212439.5786D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, David S. Miller wrote:

>    I really think it should be a compile-time option to have it default to on,
>    but I never figured out who maintains it.
> 
> How then would you get a generic, yet NFS-ROOT capable kernel?
> Answer: you can't

 Still it's quite dumb you *have* to specify "ip=<whatever>" whenever you
specify "root=nfs" to boot successfully, since the latter usually implies
you need IP to work.  I have a hack that fixes it (I need it due to a
37-character limit of a bootstrap command line in a firmware), but I
recall a discussion the conclusion of which was the current behaviour is
blessed, so I didn't even try to bother anyone with it... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

