Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283056AbRLHRnr>; Sat, 8 Dec 2001 12:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283045AbRLHRnh>; Sat, 8 Dec 2001 12:43:37 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45229 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S283009AbRLHRnY>; Sat, 8 Dec 2001 12:43:24 -0500
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
To: Anton Blanchard <anton@samba.org>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF4AC865AC.00ED861C-ON85256B1C.0060D84F@raleigh.ibm.com>
From: "Niels Christiansen" <nchr@us.ibm.com>
Date: Sat, 8 Dec 2001 12:43:22 -0500
X-MIMETrack: Serialize by Router on D04NM104/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 12/08/2001 12:43:23 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

| > > There's several things where per cpu data is useful; low frequency
| > > statistics is not one of them in my opinion.
| >
| > ...which may be true for 4-ways and even 8-ways but when you get to
| > 32-ways and greater, you start seeing cache problems.  That was the
| > case on AIX and per-cpu counters was one of the changes that helped
| > get the spectacular scalability on Regatta.
|
| I agree there are large areas of improvement to be done wrt cacheline
| ping ponging (see my patch in 2.4.17-pre6 for one example), but we
| should do our own benchmarking and not look at what AIX has been doing.

Oh, please!  You voiced an opinion.  I presented facts.  Nobody suggested
we should not measure on Linux.  As a matter of fact, I suggested that
Kiran does tests on the real counters and he said he would.

Niels

