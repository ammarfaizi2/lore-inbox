Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSHFUer>; Tue, 6 Aug 2002 16:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSHFUeq>; Tue, 6 Aug 2002 16:34:46 -0400
Received: from hdfdns01.hd.intel.com ([192.52.58.10]:13277 "EHLO
	mail1.hd.intel.com") by vger.kernel.org with ESMTP
	id <S315630AbSHFUep>; Tue, 6 Aug 2002 16:34:45 -0400
Message-ID: <39B5C4829263D411AA93009027AE9EBB1329958F@fmsmsx35.fm.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "'frankeh@watson.ibm.com'" <frankeh@watson.ibm.com>,
       "Seth, Rohit" <rohit.seth@intel.com>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: RE: large page patch (fwd) (fwd)
Date: Tue, 6 Aug 2002 13:38:09 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 4GB TLB entry size ??? 
> I assume you mean 4MB TLB entry size or did I fall
> into a coma for 10 years

That wasn't a typo ... Itanium2 supports page sizes up
to 4 Gigabytes.  Databases (well, Oracle for sure) want
to use those huge TLB entries to map their multi-gigabyte
shared memory areas.

-Tony

