Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279271AbRJ2RaM>; Mon, 29 Oct 2001 12:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274426AbRJ2RaC>; Mon, 29 Oct 2001 12:30:02 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:21921 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S279311AbRJ2R3w>; Mon, 29 Oct 2001 12:29:52 -0500
Date: Mon, 29 Oct 2001 18:28:07 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: hps@intermeta.de
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac4
In-Reply-To: <9rk2qd$li0$1@forge.intermeta.de>
Message-ID: <Pine.GSO.3.96.1011029182448.3407L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Henning P. Schmiedehausen wrote:

> Hm. If this is like the 8253 (ugh, way way back in the good old 8085
> days I really wired and programmed such a bugger on my CP/M system...), 
> then the problem is, that the 16 bit counter is read in two 8 bit portions. 
[...]
> This will happen all the time, so printing out is neither a good idea
> nor is the read problem described above an error. It is just a quirk
> in using an 8 bit chip in an 16 bit environment without being able to
> "latch" the count.

 The 8254 is indeed upwards compatible to the 8253.  Both provide a
counter latch command and the 8254 has an additional "read back" command,
which is also capable of latching counters.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

