Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268539AbTBWUYL>; Sun, 23 Feb 2003 15:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268547AbTBWUYL>; Sun, 23 Feb 2003 15:24:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15744
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268539AbTBWUYK>; Sun, 23 Feb 2003 15:24:10 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1046031687.2140.32.camel@bip.localdomain.fake>
References: <E18moa2-0005cP-00@w-gerrit2>
	 <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
	 <20030223082036.GI10411@holomorphy.com>
	 <b3b6oa$bsj$1@penguin.transmeta.com>
	 <1046031687.2140.32.camel@bip.localdomain.fake>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046036113.1670.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 23 Feb 2003 21:35:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-23 at 20:21, Xavier Bestel wrote:
> > they load faster too (which is important - you can make your CPU have
> > big caches, but _nothing_ saves you from the cold-cache costs). 
> 
> Next step: hardware gzip ?

gzip doesn't work because its not unpackable from an arbitary point. x86
in many ways is compressed, with common codes carefully bitpacked. A
horrible cisc design constraint for size has come full circle and turned
into a very nice memory/cache optimisation

