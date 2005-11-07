Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVKGU4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVKGU4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVKGU4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:56:07 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:40788 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S964877AbVKGU4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:56:06 -0500
To: agl@us.ibm.com, rohit.seth@intel.com
Subject: RE: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: ak@suse.de, akpm@osdl.org, andy@thermo.lanl.gov, arjan@infradead.org,
       arjanv@infradead.org, gmaxwell@gmail.com, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@mbligh.org,
       mel@csn.ul.ie, mingo@elte.hu, nickpiggin@yahoo.com.au,
       torvalds@osdl.org
In-Reply-To: <1131396662.18176.41.camel@akash.sc.intel.com>
Message-Id: <20051107205532.CF888185988@thermo.lanl.gov>
Date: Mon,  7 Nov 2005 13:55:32 -0700 (MST)
From: andy@thermo.lanl.gov (Andy Nelson)
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>Isn't it true that most of the times we'll need to be worrying about
>run-time allocation of memory (using malloc or such) as compared to
>static.

Perhaps for C. Not neccessarily true for Fortran. I don't know
anything about how memory allocations proceed there, but there
are no `malloc' calls (at least with that spelling) in the language 
itself, and I don't know what it does for either static or dynamic 
allocations under the hood. It could be malloc like or whatever
else. In the language itself, there are language features for
allocating and deallocating memory and I've seen code that 
uses them, but haven't played with it myself, since my codes 
need pretty much all the various pieces memory all the time, 
and so are simply statically defined.

If you call something like malloc yourself, you risk portability 
problems in Fortran. Fortran 2003 supposedly addresses some of
this with some C interop features, but only got approved within 
the last year, and no compilers really exist for it yet, let
alone having code written.


Andy

