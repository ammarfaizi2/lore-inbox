Return-Path: <linux-kernel-owner+w=401wt.eu-S1753395AbWLOUO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbWLOUO3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbWLOUO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:14:29 -0500
Received: from lazybastard.de ([212.112.238.170]:35078 "EHLO
	longford.lazybastard.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbWLOUO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:14:28 -0500
Date: Fri, 15 Dec 2006 20:11:27 +0000
From: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Pavel Machek <pavel@ucw.cz>, Scott Preece <sepreece@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/v2] CodingStyle updates
Message-ID: <20061215201127.GA32210@lazybastard.org>
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com> <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de> <20061215142206.GC2053@elf.ucw.cz> <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com> <20061215150717.GA2345@elf.ucw.cz> <20061215090037.05c021af.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061215090037.05c021af.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 December 2006 09:00:37 -0800, Randy Dunlap wrote:
> On Fri, 15 Dec 2006 16:07:17 +0100 Pavel Machek wrote:
> 
> > Not in simple cases.
> > 
> > 	3*i + 2*j should be writen like that. Not like
> > 	(3 * i) + (2 * j)
> 
> I would just write it as:
> 	3 * i + 2 * j

So would I.  But I definitely wouldn't write
	for (i = 0; i < 10; i += 2)
because I prefer the grouping in
	for (i=0; i<10; i+=2)

Pavel may have picked a bad example, but there are cases when spaces can
be used to group code.  Just as empty lines can be used to group code.
And in both cases the reason should be "readability".

Which variant is the most readable is a highly personal matter and may
alos change over time for any group of people.  I'd vote against a stone
tablet with 10 commandments of taste.  "Make it readable, use common
sense" is so much better, imo.

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories
