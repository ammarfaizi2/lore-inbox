Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135257AbRDLSyw>; Thu, 12 Apr 2001 14:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135256AbRDLSyn>; Thu, 12 Apr 2001 14:54:43 -0400
Received: from front7m.grolier.fr ([195.36.216.57]:31683 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S135252AbRDLSyd> convert rfc822-to-8bit; Thu, 12 Apr 2001 14:54:33 -0400
Date: Thu, 12 Apr 2001 17:43:33 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: lomarcan@tin.it
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape Corruption - update
In-Reply-To: <20010412084318.LESP2878.fep02-svc.tin.it@fep41-svc.tin.it>
Message-ID: <Pine.LNX.4.10.10104121738490.1202-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001 lomarcan@tin.it wrote:

> Still experimenting with my SDT-9000... tried connecting it to another
> controller
> (2940AU in place of 2904, sorry but I've only Adaptec stuff :). Same
> problem.
> Tried with another tape (even with an old DDS-2 tape). Same. Even tried
> another
> cable/removing the CDWR drive from the bus.
> 
> It seems that the tape is written incorrectly. I wrote some large file
> (300MB)
> and read it back four time. The read copies are all the same. They differ
> from the original only in 32 consecutive bytes (the replaced values SEEM
> random). Of course, 32 bytes in 300MB tar.gz files are TOO MUCH to be 
> accepted :)

A similar problem has been reported under Linux/PPC a couple of weeks ago
using a sym53c875 controller. In this case, kernel 2.2 was fine.

> Now I'll build some old 2.2 kernel to try...

If 2.2 is ok with your tape, a software error in 2.4 gets very likely, in
my opinion.

  Gérard.

