Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSDXRe7>; Wed, 24 Apr 2002 13:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312427AbSDXRe6>; Wed, 24 Apr 2002 13:34:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3461 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312426AbSDXRe6>;
	Wed, 24 Apr 2002 13:34:58 -0400
Date: Wed, 24 Apr 2002 10:25:28 -0700 (PDT)
Message-Id: <20020424.102528.98393867.davem@redhat.com>
To: greearb@candelatech.com
Cc: jd@epcnet.de, linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CC6EBF1.9060902@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Wed, 24 Apr 2002 10:31:29 -0700
   
   Maybe it could just WARN and still bring it up, if it's just
   an MTU issue?  (Or is this a total failure of VLAN support you
   are talking about?)
   
This creates a support issue.  It's almost impossible to field
bug reports effectively once you start letting users do stuff
like this.

   Also, is there any good reason that we can't get at least a compile
   time change into some of the drivers like tulip where we know we can
   get at least MOST of the cards supported with a small change?
   
   I know the driver writers hate cruft in the drivers, but we have had
   ppl using the patches in production machines for months, if not years,
   with no ill effects.
   
But the changes are wrong, just because they work for some people
doesn't make the change mergeable into the main tree.

   The same argument applies to the EEPRO driver (we know a cure, but it's
   a magic register number, and no one will accept the patch).

Intel is making strides with their e1000 and e100 drivers, just give
them some time.

Also Jeff is in a rut right and busy with some things, once he gets
back up to speed you can expect a lot of these issues to be dealt
with.

Franks a lot,
David S. Miller
davem@redhat.com
