Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVAOVrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVAOVrr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 16:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVAOVpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 16:45:40 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:13528 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262340AbVAOVnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 16:43:03 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Date: Sat, 15 Jan 2005 22:43:21 +0100
User-Agent: KMail/1.7.1
Cc: hugang@soulinfo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <20050114143400.GA27657@hugang.soulinfo.com> <200501141825.42407.rjw@sisk.pl>
In-Reply-To: <200501141825.42407.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501152243.21483.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 14 of January 2005 18:25, Rafael J. Wysocki wrote:
> On Friday, 14 of January 2005 15:34, hugang@soulinfo.com wrote:
> > On Thu, Jan 13, 2005 at 07:09:24PM +0100, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > 
> > > Has this patch been ported to x86_64?  Or is there a newer version of it anywhere,
> > > or an alternative?
> > > 
> > 
> > Ok, Here is a new patch with x86_64 support, But I have not machine, So
> > Need someone test it. 
> 
> OK, I will.

I have tested it and it works well.  For me, it speeds up the resume process significantly,
so I vote for including it into -mm (at least ;-)).  I'll be testing it further to see if it really
solves my "out of memory" problems on resume.

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
