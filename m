Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130165AbRBGWuV>; Wed, 7 Feb 2001 17:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130495AbRBGWuM>; Wed, 7 Feb 2001 17:50:12 -0500
Received: from hilbert.umkc.edu ([134.193.4.60]:9481 "HELO tesla.umkc.edu")
	by vger.kernel.org with SMTP id <S130165AbRBGWuE>;
	Wed, 7 Feb 2001 17:50:04 -0500
Message-ID: <3A81D0E5.B9F3794E@kasey.umkc.edu>
Date: Wed, 07 Feb 2001 16:49:09 -0600
From: "David L. Nicol" <david@kasey.umkc.edu>
Organization: University of Missouri - Kansas City   supercomputing infrastructure
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: OK to mount multiple FS in one dir?
In-Reply-To: <3A7E1942.5090903@goingware.com> <20010205180646.B32155@cadcamlab.org> <033601c09075$a60e43e0$de00a8c0@homeip.net> <20010206154616.A9875@animx.eu.org> <20010207002510.A10556@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
 
> A more useful thing to fall out of the same hacking is loopback
> mounting -- i.e. the same filesystem mounted multiple places.  In
> Linux-land I guess we call it 'mount --bind'.
> 
> Peter

Does this kind of thing play nice with nfs and coda, in terms of
change notifications and write-backs? In distributed FS we've got
the same thing mounted multiple places, of course, but not on the
same machine



-- 
                      David Nicol 816.235.1187 dnicol@cstp.umkc.edu
                           Pedestrians always have the right of way

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
