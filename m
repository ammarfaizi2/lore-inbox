Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWAESko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWAESko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWAESko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:40:44 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:46253 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932069AbWAESkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:40:43 -0500
Date: Thu, 5 Jan 2006 19:40:42 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Jiri Slaby <lnx4us@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] reproducable hang
Message-ID: <20060105184031.GA10923@vanheusden.com>
References: <20060103210252.GA2043@vanheusden.com>
	<3888a5cd0601050846i129fd0a5j71d24150b1e0bcd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3888a5cd0601050846i129fd0a5j71d24150b1e0bcd1@mail.gmail.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Fri Jan  6 19:20:40 CET 2006
X-Message-Flag: www.vanheusden.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Since 2.6.14 (I also tried 2.6.14.4 and 2.6.15), my pc crashes (hangs)
> > when I set eth1 into promisques mode.
> > The crash (no oops or panic!) does NOT crash when I run tcpdump (or any other
> > traffic monitor) on eth0 or eth2.
> > The eth1 card is a 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24).
> > Receiving/sending data through that card works fine.
> sysrq is defunct? try sysrq-t to trace back the running stack.

No luck there I'm afraid.
BUT: the last message on the console is: 'eth1: transmit error Tx status
register 82'. This message is not in any logfiles so it must have
happened pretty much arround the crash.


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
