Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSEDQV5>; Sat, 4 May 2002 12:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314621AbSEDQV4>; Sat, 4 May 2002 12:21:56 -0400
Received: from air-2.osdl.org ([65.201.151.6]:54285 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314584AbSEDQVx>;
	Sat, 4 May 2002 12:21:53 -0400
Date: Sat, 4 May 2002 09:21:17 -0700 (PDT)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 release 2.4 
In-Reply-To: <Pine.LNX.4.44.0205041357110.12156-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0205040920070.22716-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2002, Zwane Mwaikambo wrote:

| On Sat, 4 May 2002, Keith Owens wrote:
|
| > You will have to provide more details of the problem that you think you
| > are seeing.  The .tmp_include files are part of the infrastructure that
| > lets me separate source and object trees, they are meant to be there.
| > make -f Makefile-2.5 mrproper deletes .tmp_include.
|
| I didn't try reproducing it, i just rm -rf'd .tmp_include when it failed.
| I'll double check.

Zwane-

I've seen this, but only when I did 'make clean' instead
of 'make -f Makefile-2.5 clean' (or was it mrproper?).
I.e., used the wrong Makefile.

-- 
~Randy

