Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270154AbRHGJYf>; Tue, 7 Aug 2001 05:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270156AbRHGJYZ>; Tue, 7 Aug 2001 05:24:25 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:15876 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S270154AbRHGJYM>; Tue, 7 Aug 2001 05:24:12 -0400
Message-ID: <3B6FB378.6BAD9A21@idb.hist.no>
Date: Tue, 07 Aug 2001 11:23:04 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-pre4 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Crutcher Dunnavant <crutcher@datastacks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de> <Pine.LNX.4.33.0108062047310.17919-100000@kobayashi.soze.net> <15215.27296.959612.765065@localhost.efn.org> <3B6F9D78.412AB717@idb.hist.no> <20010807035828.E2399@mueller.datastacks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crutcher Dunnavant wrote:
> 
> ++ 07/08/01 09:49 +0200 - Helge Hafting:
> > Steve VanDevender wrote:
> > I can remove RAM live, and read it in another device.  Or replace
> 
> Eek. I dont think I'm gonna sleep well on this one.
> Umm, tamper-crash cases that kill the power?

It's all about how well you protect the machine
versus how easy I can get around it.  Yanking a RAM chip
and inserting it in another pc running dos isn't hard,
with physical access.  

Killing the power isn't enough,
I have a few seconds to get the chip and can smash the
case open with force.  You need a self-destruct
device in a safe, or guards.  

A relatively cheap way might be a custom pci
card with a self-destruct RAM bank for
storing the decryption keys.  Opening the 
safe cause the card to zero the RAM.  

The key(s) exists only in this special
RAM, and processor registers during
decryption.

Helge Hafting
