Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbRAANSY>; Mon, 1 Jan 2001 08:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131515AbRAANSF>; Mon, 1 Jan 2001 08:18:05 -0500
Received: from shiva.jussieu.fr ([134.157.0.129]:9734 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id <S131324AbRAANRz>;
	Mon, 1 Jan 2001 08:17:55 -0500
From: Roberto Di Cosmo <Roberto.Di-Cosmo@pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14928.35348.19827.848973@localhost.localdomain>
Date: Mon, 1 Jan 2001 14:45:56 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: [e2compr PATCH]: announcing beta port to kernel 2.2.18
X-Mailer: VM 6.72 under 21.1 (patch 9) "Canyonlands" XEmacs Lucid
Reply-To: Roberto Di Cosmo <roberto@dicosmo.org>
Cc: demolinux@demolinux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear mailing list members,
     I am unable to join the maintainers/developers of the extended 2 
compressed filesystem patch at e2compr-announce@opensource.captech.com,
so I think you are the best available audience for this announce, and
I hope some of the developers/maintainers of e2compr will be listening
too.

I have uploaded at
http://www.pps.jussieu.fr/~dicosmo/Linux/e2compr/e2compr-0.4.39-patch-2.2.18.bz2
a minor modification of the e2compr-0.4.38 kernel patch, adapted to compile
versus the latest 2.2.18 stable kernel. This was needed to allow us to upgrade
to a more recent kernel version in the next DemoLinux (see www.demolinux.org).
 
It seems to properly operate under reasonable charge for me,
even if once in a while I get a sequence of errors
 
       Whoops: end_buffer_io_async: async io complete on unlocked page
 
not necessarily when using ext2 compressed filesystems.
 
Please feel free to use it (at your own risk), test it and report bugs
to dicosmo@pps.jussieu.fr

Notice, though, that I am not applying to become an official maintainer
of the package: I just needed to spend some time to get it almost working
and I wanted to give back the contribution to the community.

Also, I am not currently subscribed to the kernel mailing list, so
please contact me directly by e-mail, for any comments.

Sincerely yours
 
--Roberto Di Cosmo
 
------------------------------------------------------------------
Professeur
PPS                      E-mail: dicosmo@pps.jussieu.fr
Universite Paris VII     WWW  : http://www.pps.jussieu.fr/~dicosmo
Case 7014                Tel  : ++33-(1)-44 27 86 55
2, place Jussieu         Fax  : ++33-(1)-44 27 68 49
F-75251 Paris Cedex 05
FRANCE.                  MIME/NextMail accepted
------------------------------------------------------------------
Office location:
 
Bureau 6C14 (6th floor)
175, rue du Chevaleret, XIII
Metro Chevaleret, ligne 6
------------------------------------------------------------------                                 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
