Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbTCLRw2>; Wed, 12 Mar 2003 12:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbTCLRw1>; Wed, 12 Mar 2003 12:52:27 -0500
Received: from bitmover.com ([192.132.92.2]:46245 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261823AbTCLRw0>;
	Wed, 12 Mar 2003 12:52:26 -0500
Date: Wed, 12 Mar 2003 10:03:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: John Bradford <john@grabjohn.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, dana.lacoste@peregrine.com,
       linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312180304.GA30788@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	John Bradford <john@grabjohn.com>, "H. Peter Anvin" <hpa@zytor.com>,
	dana.lacoste@peregrine.com, linux-kernel@vger.kernel.org,
	lm@bitmover.com
References: <3E6F6E84.1010601@zytor.com> <200303121757.h2CHveVF001517@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303121757.h2CHveVF001517@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I thought that BK has been able to export everything to a text file
> since the first version.

bk export -tpatch -r1.900 > patch.1.900
bk changes -v -r1.900 > comments.1.900

Been there forever.  So has ways to get all the metadata from the command
line without having to reverse engineer the file format.  See

    http://www.bitkeeper.com/manpages/bk-prs-1.html

it's all there.  Always has been.

Wayne wanted me to point that it is easy to write the BK to CVS exporter
completely from the command line, we prototyped it that way, the only
reason we rewrote part of it in C was for performance.  The point being
that you guys could have done this yourself without help from us because
all the metadata is right there.  Ditto for anyone else worried about 
getting their data out of BK now or in the future.  The whole point of
prs is to be able to have a will-always-work way to get at the data or
the metadata, it makes the file format a non-issue.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
