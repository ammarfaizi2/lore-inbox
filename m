Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTFZRKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 13:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTFZRKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 13:10:15 -0400
Received: from zephir.uk.clara.net ([195.8.69.53]:4875 "EHLO
	zephir.uk.clara.net") by vger.kernel.org with ESMTP id S262153AbTFZRKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 13:10:13 -0400
Subject: Re: weird postfix mailspool corruption with 2.4.21-ac2+ (was Re:
	Linux 2.4.21-ac3)
From: Jonathan Hudson <jonathan@daria.co.uk>
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030625191906.C9146@newbox.localdomain>
References: <fa.hh6ttrp.1d52bhj@ifi.uio.no> <fa.h3c32fv.r5m12l@ifi.uio.no>
	 <f65.3efa238d.6e30e@trespassersw.daria.co.uk>
	 <20030625191906.C9146@newbox.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1056648260.7417.7.camel@trespassersw.daria.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 26 Jun 2003 18:24:20 +0100
X-PGP-KeyServer: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0x721FAABE
X-PGP-Key: 1024/DSA 0x721FAABE
X-PGP-Fingerprint: 7746 1FEE 02F4 0AD4 267C 2B55 03EF 19EC 721F AABE
X-Operating-System: Linux 2.4.22-pre1 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-26 at 00:19, Scott McDermott wrote:
> Jonathan Hudson on Wed 25/06 23:34 +0100:
> > No AIC or any kind here. Bring on the next suspect.
> 
> does changing the unix_dgram_ops `poll' op from `dgram_poll'
> to `datagram_poll' in net/unix/af_unix.c change anything for
> you? I can't test this myself until later this week.  Also I
> don't know what other bug the unix_peer_get() addition is
> supposed to fix, so...

I'll see if I can test this out, once I've build -ac3 on a box where I
don't drop real messages.

-jonathan

