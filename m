Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbTDGHbe (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 03:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263314AbTDGHbe (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 03:31:34 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:39119 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263312AbTDGHbd (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 03:31:33 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.11269.576246.373826@laputa.namesys.com>
Date: Mon, 7 Apr 2003 11:43:01 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Nicholas Wourms <dragon@gentoo.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove kdevname() before someone starts using it again
In-Reply-To: <3E908DF6.1050004@gentoo.org>
References: <20030331162634.A14319@lst.de>
	<3E908DF6.1050004@gentoo.org>
X-Mailer: VM 7.07 under 21.5  (beta11) "cabbage" XEmacs Lucid
X-Tom-Swifty: "I train dolphins," Tom said purposefully.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Wourms writes:
 > 
 > A quick grep shows that Intermezzo FS still uses kdevname if 
 > you've turned on debugging (fs/intermezzo/sysctl.c).  As for 
 > pending stuff, both Reiser4 & pktcdvd also use it.  So I 

reiser4 switched to bdevname().

 > guess people are still using it...  What is your reason for 
 > removing it?
 > 
 > Cheers,
 > Nicholas

Nikita.

