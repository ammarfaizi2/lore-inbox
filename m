Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317996AbSGRDTy>; Wed, 17 Jul 2002 23:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317999AbSGRDTy>; Wed, 17 Jul 2002 23:19:54 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:41642 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317996AbSGRDTx>;
	Wed, 17 Jul 2002 23:19:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu, trond.myklebust@fys.uio.no,
       Matija Nalis <mnalis-umsdos@voyager.hr>, aia21@cantab.net,
       al@alarsen.net, asun@cobaltnet.com, bfennema@falcon.csc.calpoly.edu,
       dave@trylinux.com, braam@clusterfs.com, chaffee@cs.berkeley.edu,
       dwmw2@infradead.org, eric@andante.org, hch@infradead.org, hpa@zytor.com,
       jaharkes@cs.cmu.edu, jakub@redhat.com, jffs-dev@axis.com,
       mikulas@artax.karlin.mff.cuni.cz, quinlan@transmeta.com,
       reiserfs-dev@namesys.com, Chris Mason <mason@suse.com>,
       rgooch@atnf.csiro.au, rmk@arm.linux.org.uk, shaggy@austin.ibm.com,
       tigran@veritas.com, urban@teststation.com, vandrove@vc.cvut.cz,
       vl@kki.org, zippel@linux-m68k.org, Art Haas <ahaas@neosoft.com>
Subject: Remain Calm: Designated initializer patches for 2.5
Date: Thu, 18 Jul 2002 13:22:23 +1000
Message-Id: <20020718032331.5A36644A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I just sent about 40 reasonable-size patches through the
Trivial Patch Monkey to Linus: these patches replace the (deprecated)
"foo: " designated initializers with the ISO-C ".foo =" initializers.
GCC has understood both since forever, but the kernel took a wrong
bet, and we're better off setting a good example for 2.6 before we
start getting about 10,000 warnings.

	So far, Art Haas has done all the fs code, and will presumably
be working through the other code on dir at a time.

Just a heads-up,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
