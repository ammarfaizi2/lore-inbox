Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbULPVRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbULPVRT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbULPVRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:17:19 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:38051 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262026AbULPVRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:17:13 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: bkbits problem?
Date: Thu, 16 Dec 2004 21:16:57 +0000
User-Agent: KMail/1.7.1
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       bitkeeper-users@bitmover.com
References: <20041216190159.GA31805@one-eyed-alien.net>
In-Reply-To: <20041216190159.GA31805@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412162116.57509.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 Dec 2004 19:01, Matthew Dharm wrote:
> Is anyone besides me having difficulty cloning a tree from
> linux.bkbits.net/linux-2.5 or 2.6?
>
> I keep getting:
>
> [mdharm@g5 mdharm]$ bk clone bk://linux.bkbits.net/linux-2.5 linux-405-2.5
> Clone bk://linux.bkbits.net/linux-2.5
>    -> file://home/mdharm/linux-405-2.5
> BAD gzip hdr
> read: No such file or directory
> 0 bytes uncompressed to 0, nanX expansion
> sfio errored
>
> I can clone from linuxusb, so I don't _think_ it's a problem on my end...
>

I reported the same thing on Sunday to the bitkeeper-users ML (see below)
Interestingly, I can 'pull' to an existing linux-2.5 repo now, but clone is 
still busted.

bitkeeper-users is deathly quiet. I got no reply since sunday. Has christmas 
started early at Bitmovers?   ;)

+-----------------------------------------+

Since yesterday night, when I try a pull an existing clone of 
bk://linux.bkbits.net/linux-2.6, I get a hang 20s hang like this:


 andrew@orac linux-bk $ bk pull
 Pull bk://linux.bkbits.net/linux-2.6
   -> file://home/andrew/kernels/linux-bk
 Nothing to pull.
 [HANG 20s or so]
 andrew@orac linux-bk $ 


If I try to get a new clone, I get some really funky stuff:

 andrew@orac test $ bk clone bk://linux.bkbits.net/linux-2.6
 Clone bk://linux.bkbits.net/linux-2.6
    -> file://home/andrew/test/linux-2.5
 BAD gzip hdr
 read: No such file or directory
 0 bytes uncompressed to 0, nanX expansion
 sfio errored
 andrew@orac test $


Tried on two seperate machines in UK and US, so I don't think its me or 
internet breakage...

Andrew Walrond
