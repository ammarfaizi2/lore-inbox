Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTDGOOE (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263465AbTDGOOE (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:14:04 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:43479 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263464AbTDGOOD (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 10:14:03 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.35421.17842.418130@laputa.namesys.com>
Date: Mon, 7 Apr 2003 18:25:33 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Nicholas Wourms <dragon@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove kdevname() before someone starts using it again
In-Reply-To: <3E91867A.1040504@gentoo.org>
References: <20030331162634.A14319@lst.de>
	<3E908DF6.1050004@gentoo.org>
	<16017.11269.576246.373826@laputa.namesys.com>
	<3E91867A.1040504@gentoo.org>
X-Mailer: VM 7.07 under 21.5  (beta11) "cabbage" XEmacs Lucid
X-Windows: no hardware is safe.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Wourms writes:
 > Nikita Danilov wrote:
 > > Nicholas Wourms writes:
 > >  > 
 > >  > A quick grep shows that Intermezzo FS still uses kdevname if 
 > >  > you've turned on debugging (fs/intermezzo/sysctl.c).  As for 
 > >  > pending stuff, both Reiser4 & pktcdvd also use it.  So I 
 > > 
 > > reiser4 switched to bdevname().
 > > 
 > 
 > When will the reiser4 bk repo be updated to reflect this? 
 > It has been pretty quiet for the last few days or so, 
 > compared to the daily updating it used to get.  As of 

It is currently undergoing some changing that rendered it unstable. I
hope in few days a lot of commits will be made.

 > yesterday, trying to compile reiser4 as a module yeilded the 
 > undefined reference to kdevname in a few places, not to 
 > mention a few other undefined references as well...

We are not paying attention to the compilability as module yet.  
Apropos, thank you for trying reiser4.

 > 
 > Cheers,
 > Nicholas
 > 

Nikita.
