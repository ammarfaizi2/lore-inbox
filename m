Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291565AbSBAG3A>; Fri, 1 Feb 2002 01:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291566AbSBAG2k>; Fri, 1 Feb 2002 01:28:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15747 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291565AbSBAG2d>;
	Fri, 1 Feb 2002 01:28:33 -0500
Date: Thu, 31 Jan 2002 22:26:43 -0800 (PST)
Message-Id: <20020131.222643.85689058.davem@redhat.com>
To: kaos@ocs.com.au
Cc: garzik@havoc.gtf.org, alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <7245.1012543865@kao2.melbourne.sgi.com>
In-Reply-To: <20020131.220121.39157969.davem@redhat.com>
	<7245.1012543865@kao2.melbourne.sgi.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Fri, 01 Feb 2002 17:11:05 +1100
   
   Except my proposal would have put all the initialization order
   information together, instead of putting some information in the
   source and some in the Makefiles.

NONE OF IT IS IN THE MAKEFILES!  Please change your perspective
to see this!

If you have a dependency concern, you put yourself in the
right initcall group.  You don't depend ever on the order within the
group, thats the whole idea.  You can't depend on that, so you must
group things correctly.

Again, if you have some dependency within the initcall group, then
you're grouping things incorrectly.  If the grouping is selected
properly, you could link in the total opposite order all the objects
and it still would work out fine.

I think your complaints are for problems that don't really exist.
