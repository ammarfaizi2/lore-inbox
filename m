Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTBNQkv>; Fri, 14 Feb 2003 11:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbTBNQkv>; Fri, 14 Feb 2003 11:40:51 -0500
Received: from bitmover.com ([192.132.92.2]:16298 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261368AbTBNQku>;
	Fri, 14 Feb 2003 11:40:50 -0500
Date: Fri, 14 Feb 2003 08:50:41 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       David Lang <david.lang@digitalinsight.com>,
       "Matthew D. Pitts" <mpitts@suite224.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
Message-ID: <20030214165041.GA6564@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tomas Szepe <szepe@pinerecords.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	David Lang <david.lang@digitalinsight.com>,
	"Matthew D. Pitts" <mpitts@suite224.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302132224470.656-100000@dlang.diginsite.com> <1045233701.7958.14.camel@irongate.swansea.linux.org.uk> <20030214153039.GB3188@work.bitmover.com> <1045241763.1353.19.camel@irongate.swansea.linux.org.uk> <20030214164720.GC200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214164720.GC200@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Larry, would it be a problem to implement something like:
> 
> alan@wherever$ echo 'rq unidiff for {1.967,1.968} of typhoon/typhoon-2.4'| \
> 	mail diffmail@bkbits.net

Sure, you can do it.

	bk clone bk://typhoon.bkbits.net/typhoon-2.4
	cd typhoon-2.4
	bk export -tpatch -r1.967,1.968 | mail alan@lxorguk.ukuu.org.uk
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
