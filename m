Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbTABCrr>; Wed, 1 Jan 2003 21:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbTABCrp>; Wed, 1 Jan 2003 21:47:45 -0500
Received: from bitmover.com ([192.132.92.2]:9864 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265469AbTABCrj>;
	Wed, 1 Jan 2003 21:47:39 -0500
Date: Wed, 1 Jan 2003 18:56:05 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       Andrew Morton <akpm@zip.com.au>, Dave Jones <davej@codemonkey.org.uk>,
       "Timothy D. Witham" <wookie@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Raw data from dedicated kernel bug database
Message-ID: <20030102025605.GE23419@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Andrew Morton <akpm@zip.com.au>,
	Dave Jones <davej@codemonkey.org.uk>,
	"Timothy D. Witham" <wookie@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030101194019.GZ5607@work.bitmover.com> <12310000.1041456646@titus> <20030101221510.GG5607@work.bitmover.com> <1041473017.22606.8.camel@irongate.swansea.linux.org.uk> <45160000.1041475166@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45160000.1041475166@titus>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Larry, can I presume that you'll reciprocate, and export whatever you
> do to the data in BK in some argument-free format (probably the same
> one we export to you)? 

Yup.  A BK database is actually a BK repostory with an SQL layer on 
top of it.  So all of the stuff you can do with BK you can do with 
BK/Database.  We can export changes as patches, as flat files, as
associative arrays in perl, take your pick.

> I think the concerns I had about tools going wild are actually fairly
> easy to resolve by making it a pull-pull interchange ... don't know
> why I was thinking of push models.

Cool.  I've already tracked down an SQL hacker who is willing to contract
with us to write the scripts to get the data out of your Bugzilla database.
He said that I need to ask you to do this:

	shut down the mysql database
	grab all the MySQL files and stuff them in a tarball
	turn on the mysql database again

Then he can set up a mysql instance here and start hacking on the scripts.
How's that sound?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
