Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbRDKMkk>; Wed, 11 Apr 2001 08:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132569AbRDKMkb>; Wed, 11 Apr 2001 08:40:31 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:30891 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132567AbRDKMkR>; Wed, 11 Apr 2001 08:40:17 -0400
Date: Wed, 11 Apr 2001 14:24:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Howells <dhowells@cambridge.redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix 
In-Reply-To: <13054.986974737@warthog.cambridge.redhat.com>
Message-ID: <Pine.GSO.3.96.1010411142138.2984E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001, David Howells wrote:

> Can CONFIG_X86_XADD be equated to CONFIG_X86_CMPXCHG?

 Yes.  Modulo very early i486s which used incorrect opcodes for cmpxchg. 
They can probably be safely ignored. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

