Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319387AbSIMA2P>; Thu, 12 Sep 2002 20:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319399AbSIMA2P>; Thu, 12 Sep 2002 20:28:15 -0400
Received: from inspired.net.au ([203.58.81.130]:60178 "EHLO inspired.net.au")
	by vger.kernel.org with ESMTP id <S319387AbSIMA2O>;
	Thu, 12 Sep 2002 20:28:14 -0400
Message-Id: <200209130032.KAA32528@thucydides.inspired.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Sep 2002 10:28:29 +1000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Pull NFS server address off root_server_path
In-Reply-To: <1031818177.2994.39.camel@irongate.swansea.linux.org.uk>
References: <200209120208.MAA00777@thucydides.inspired.net.au>
	<1031818177.2994.39.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.90.3
From: "Martin Schwenke" <martin@meltin.net>
Reply-To: "Martin Schwenke" <martin@meltin.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    Alan> You are probably much better using the initrd based dhcp
    Alan> client from things like the LTSP project (ltsp.org) than the
    Alan> kernel one

That's probably true in the long term.  For the short term, is the
initrd-based stuff working right now?  I didn't think it was quite
there yet...

If the patch goes in now, I won't be terribly disappointed if it comes
back out, along with (most of) the rest of the ipconfig stuff, if the
initrd-based stuff works acceptably before the feature freeze...

I would think that if there's a chance that the ipconfig stuff will
stay in for 2.6, and this patch improves it, then it should probably
be merged.  The patch has been in use at OzLabs for about 6 months
(since I moved the DHCP server off the NFS server :-) to help boot the
embedded boxes that David Gibson is doing bring-up work on.

peace & happiness,
martin
