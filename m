Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271212AbTGYQIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 12:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272170AbTGYQIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 12:08:53 -0400
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:23250 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S271212AbTGYQIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 12:08:52 -0400
Date: Fri, 25 Jul 2003 12:23:37 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Net device byte statistics
In-reply-to: <200307250654.h6P6s9j05200@Port.imtp.ilyichevsk.odessa.ua>
To: vda@port.imtp.ilyichevsk.odessa.ua,
       Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
Message-id: <200307251223.51849.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <E19fqMF-0007me-00@calista.inka.de>
 <200307250654.h6P6s9j05200@Port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 25 July 2003 03:03, Denis Vlasenko wrote:
> I sample the data every minute. Will need to do it much more often
> on 10ge ifaces, when those will appear at my home ;)

Speed			Time for one overflow

10Gbits/s	=> 3.436 seconds
1Gbit/s		=> 34.36 seconds
100Mbits/s	=> 343.6 seconds

> Or we will need 64bit counters then.

For anything up to (and including) 1GBit/s it is possible to do in easily in 
userspace, but then were are getting into an area where a program would have 
to check the files every 3 seconds (and a bit of load could delay it long 
enough for an overflow to happen.)

Jeff.

- -- 
FORTUNE PROVIDES QUESTIONS FOR THE GREAT ANSWERS: #19
A:      To be or not to be.
Q:      What is the square root of 4b^2?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IVmNwFP0+seVj/4RAioPAJ0Y9+lsU/pcwubJeyt8sIogOJt7/ACgoNhT
o1qluqX84CNqU2du7WXG4Eo=
=IlX4
-----END PGP SIGNATURE-----

