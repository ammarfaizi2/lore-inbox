Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264714AbSKVNUa>; Fri, 22 Nov 2002 08:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSKVNUa>; Fri, 22 Nov 2002 08:20:30 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:47884 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264714AbSKVNU3>; Fri, 22 Nov 2002 08:20:29 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15838.12484.46897.60190@laputa.namesys.com>
Date: Fri, 22 Nov 2002 16:27:32 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kentborg@borg.org
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
In-Reply-To: <1037972308.11846.7.camel@irongate.swansea.linux.org.uk>
References: <200211220122.gAM1MQY305783@saturn.cs.uml.edu>
	<3DDD88BB.209@pobox.com>
	<1037972308.11846.7.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Flame: Reagan is a coward, huh?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Fri, 2002-11-22 at 01:30, Jeff Garzik wrote:
 > > Albert D. Cahalan wrote:
 > > 
 > > > Forget the shred program. It's less useful than having the
 > > > filesystem simply zero the blocks, because it's slow and you
 > > > can't be sure to hit the OS-visible blocks.
 > > 
 > > 
 > > Why not?
 > > 
 > > Please name a filesystem that moves allocated blocks around on you.  And 
 > > point to code, too.
 > 
 > Anything on IDE or SCSI or Flash. Just its done below you

Journalling file systems also may leave copies of data in the journal area(s).

 > 

Nikita.
