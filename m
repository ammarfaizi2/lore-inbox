Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317741AbSFLQhe>; Wed, 12 Jun 2002 12:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSFLQhd>; Wed, 12 Jun 2002 12:37:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:50949 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317734AbSFLQhc>;
	Wed, 12 Jun 2002 12:37:32 -0400
Date: Wed, 12 Jun 2002 09:32:46 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Ravikiran G Thirumalai <kiran@in.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: question: i/o port 0x61 on x86 archs
In-Reply-To: <Pine.GSO.3.96.1020612183253.8068D-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33L2.0206120931070.5023-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, Maciej W. Rozycki wrote:

| On Wed, 12 Jun 2002, Ingo Oeser wrote:
|
| > > Port 0x61 is the NMI status and control register.
| >
| > So it should exist a '#define' for this somewhere.
| >
| > People who tend to disagree here, may try to use *.i files
| > instead of *.c and *.h files next time.
|
|  Feel free to submit a patch.

I say "please submit a patch."
I very much dislike such inline constants
(for register offsets and register bits).

-- 
~Randy

